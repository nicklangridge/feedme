package FeedMe::Feed::UnderTheRadar;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::DOM';

sub name         { 'Under the Radar' };
sub url          { 'http://www.undertheradarmag.com/reviews/category/music' };
sub homepage_url { 'http://www.undertheradarmag.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  my %urls = map { $_ => 1 } grep {$_ =~ /.*www\.undertheradarmag\.com\/reviews\/.+/} @urls;
  
  return keys %urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html  = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom   = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $artist = eval { $dom->at('.headline h3')->all_text } || '';
  my $album = eval { $dom->at('.headline h4')->all_text } || '';
  
  return {
    title   => trim($artist) . ' - ' . trim($album),
    url     => trim $url,
  }
}

1;