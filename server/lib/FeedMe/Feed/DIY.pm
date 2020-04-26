package FeedMe::Feed::DIY;
use Moo;
use Method::Signatures;
use Text::Trim;
use FeedMe::Utils::Snippet qw(snippet);
use feature 'say';

with 'FeedMe::Role::Feed::DOM';

sub name         { 'DIY' };
sub url          { 'https://diymag.com/reviews/album' };
sub homepage_url { 'https://diymag.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  # https://crackmagazine.net/article/album-reviews/...
  my %urls = map { $_ => 1 } grep {$_ =~ /.*diymag\.com\/.+album-review$/} @urls;
say join "\n", keys %urls;
  return keys %urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html  = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom   = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";
  my $title = eval { $dom->at('.h-headline__main')->all_text } || '';

  return {
    title       => trim $title,
    url         => trim $url,
    description => undef,
  }
}


1;
