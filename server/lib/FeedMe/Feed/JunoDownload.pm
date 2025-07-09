package FeedMe::Feed::JunoDownload;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;
use List::Util qw(uniq);
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::DOM';

sub name         { 'Electronica' };
sub url          { 'https://www.junodownload.com/all/this-week/releases/?music_product_type=album&order=date_down&facet%5Bfeatured%5D%5B0%5D=3' };
sub homepage_url { 'https://www.junodownload.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = uniq @{ $dom->find('a.juno-title')->map(attr => 'href')->compact };
  @urls = map { $self->homepage_url . $_ } @urls;
  return @urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html   = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom    = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $artist = eval { $dom->at('.product-artist a')->all_text } || '';
  my $album  = eval { $dom->at('.product-title a')->all_text } || '';
  my $review = eval { $dom->at('span[itemprop="reviewBody"]')->all_text } || '';

  return {
    title       => join(' - ', trim $artist, trim $album),
    url         => trim $url,
    description => snippet($review, 200),
  }
}

1;
