package FeedMe::Feed::Juno;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;
use List::Util qw(uniq);
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::DOM';

sub name         { 'Electronica' };
sub url          { 'https://www.juno.co.uk/all/this-week/?music_product_type=album&order=date_down&facet%5Bfeatured_physical%5D%5B0%5D=2&facet%5Bsubgenre_id%5D%5B%5D=28%7C%7C2&facet%5Bsubgenre_id%5D%5B%5D=28%7C%7C6&facet%5Bsubgenre_id%5D%5B%5D=28%7C%7C7&facet%5Bsubgenre_id%5D%5B%5D=28%7C%7C11&facet%5Bsubgenre_id%5D%5B%5D=28%7C%7C10&facet%5Bsubgenre_id%5D%5B%5D=35%7C%7C2&facet%5Bsubgenre_id%5D%5B%5D=35%7C%7C6&facet%5Bsubgenre_id%5D%5B%5D=28%7C%7C9&facet%5Bsubgenre_id%5D%5B%5D=28%7C%7C8&facet%5Bsubgenre_id%5D%5B%5D=39%7C%7C1&facet%5Bsubgenre_id%5D%5B%5D=28%7C%7C5&facet%5Bsubgenre_id%5D%5B%5D=5%7C%7C2&facet%5Bsubgenre_id%5D%5B%5D=26%7C%7C1&facet%5Bsubgenre_id%5D%5B%5D=35%7C%7C1&facet%5Bsubgenre_id%5D%5B%5D=19%7C%7C3&facet%5Bsubgenre_id%5D%5B%5D=15%7C%7C9&facet%5Bsubgenre_id%5D%5B%5D=12%7C%7C3&facet%5Bsubgenre_id%5D%5B%5D=15%7C%7C4&facet%5Bsubgenre_id%5D%5B%5D=19%7C%7C2&facet%5Bsubgenre_id%5D%5B%5D=19%7C%7C4&facet%5Bsubgenre_id%5D%5B%5D=30%7C%7C2&facet%5Bsubgenre_id%5D%5B%5D=6%7C%7C2&facet%5Bsubgenre_id%5D%5B%5D=15%7C%7C6&facet%5Bsubgenre_id%5D%5B%5D=19%7C%7C5&facet%5Bsubgenre_id%5D%5B%5D=32%7C%7C1&facet%5Bsubgenre_id%5D%5B%5D=15%7C%7C3&facet%5Bsubgenre_id%5D%5B%5D=14%7C%7C1' };
sub homepage_url { 'https://www.juno.co.uk' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = uniq @{ $dom->find('.pl-info a.text-md')->map(attr => 'href')->compact };
  @urls = map { $self->homepage_url . $_ } grep {/^\/products\//} @urls;
  return @urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html   = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom    = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $artist = eval { $dom->at('h2[itemprop="byArtist"] a')->all_text } || '';
  my $album  = eval { $dom->at('.product-title span[itemprop="name"]')->all_text } || '';
  ($album) = split /\(/, $album; # remove annotation in brackets e.g. "title (reissue)" - a cludge; might lose genuine title info
  my $review = eval { $dom->at('p[itemprop="reviewBody"]')->all_text } || '';

  return {
    title       => join(' - ', trim $artist, trim $album),
    url         => trim $url,
    description => snippet($review, 200),
  }
}

1;
