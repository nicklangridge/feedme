package FeedMe::Feed::NME;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;

with 'FeedMe::Role::Feed::DOM';

sub name         { 'NME' };
sub url          { 'https://www.nme.com/reviews/album' };
sub homepage_url { 'http://www.nme.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  my %urls = map { $_ => 1 } grep {$_ =~ /.*www\.nme\.com\/reviews\/album\/.+/} @urls;

  return keys %urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html  = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom   = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $title = eval { $dom->at('.tdb-title-text')->all_text } || '';
  
  # artist - ‘album’ review
  $title =~ s/(:?review:\s*.*)$//;
  $title =~ s/[\x{2018}\x{2019}‘’']//g;
  #warn $title;
  
  return {
    title   => trim $title,
    url     => trim $url,
  }
}

1;
