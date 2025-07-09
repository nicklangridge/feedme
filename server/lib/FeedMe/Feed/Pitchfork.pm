package FeedMe::Feed::Pitchfork;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;
use List::Util qw(uniq);
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::DOM';

sub name         { 'Pitchfork' };
sub url          { 'https://pitchfork.com/reviews/albums/' };
sub homepage_url { 'https://pitchfork.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = uniq @{ $dom->find('*')->map(attr => 'href')->compact };
  @urls = map { $self->homepage_url . $_ } grep {$_ =~ /^\/reviews\/albums\//} @urls;
  return @urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html    = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom     = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $artist  = eval { $dom->find('div[class*="SplitScreenContentHeaderArtist"]')->first->all_text } || '';
  my $album   = eval { $dom->find('h1[class*="SplitScreenContentHeaderHed"]')->first->all_text } || '';
  my $snippet = eval { $dom->find('div[class*="SplitScreenContentHeaderDekDown"]')->first->all_text } || '';
  return {
    title       => join(' - ', trim $artist, trim $album),
    url         => trim $url,
    description => snippet($snippet, 200),
  }
}

1;
