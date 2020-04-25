package FeedMe::Feed::Crack;
use Moo;
use Method::Signatures;
use Text::Trim;
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::DOM';

sub name         { 'Crack' };
sub url          { 'https://crackmagazine.net/album-reviews' };
sub homepage_url { 'https://crackmagazine.net' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  # https://crackmagazine.net/article/album-reviews/...
  my %urls = map { $_ => 1 } grep {$_ =~ /.*crackmagazine\.net\/article\/album-reviews\/.+$/} @urls;

  return keys %urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html  = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom   = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $album  = eval { $dom->at('.album-title')->text } || '';
  my $artist = eval { $dom->at('.album-artist')->text } || '';

  my $title = trim($artist ) . ' - ' . trim($album);
  
  return {
    title       => $title,
    url         => trim $url,
    description => undef,
  }
}

1;
