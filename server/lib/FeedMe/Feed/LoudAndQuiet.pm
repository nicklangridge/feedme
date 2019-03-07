package FeedMe::Feed::LoudAndQuiet;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;

with 'FeedMe::Role::Feed::DOM';

sub name         { 'Loud and Quiet' };
sub url          { 'https://www.loudandquiet.com/reviews' };
sub homepage_url { 'https://www.loudandquiet.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  my %urls = map { $_ => 1 } grep {$_ =~ /.*www\.loudandquiet\.com\/reviews\/.+/} @urls;
  
  return keys %urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html  = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom   = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $title = eval { $dom->at('.loudandquiet-article__container h1')->to_string } || '';
  
  # "<h1>artist<br>album</h1>" --> "artist - album"
  $title =~ s/<br\s*\/*>/ - /;
  $title =~ s/<\/*h1>//g;
  #warn $title;
  
  return {
    title   => trim $title,
    url     => trim $url,
  }
}

1;