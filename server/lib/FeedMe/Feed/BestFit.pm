package FeedMe::Feed::BestFit;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;

with 'FeedMe::Role::Feed::DOM';

sub name         { 'The Line of Best Fit' };
sub url          { 'https://www.thelineofbestfit.com/reviews/albums' };
sub homepage_url { 'https://www.thelineofbestfit.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  @urls = map { "https:$_" } grep {$_ =~ /.*www\..*\/reviews\/albums\/[^\/]+review/} @urls;
  return @urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html   = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom    = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $artist = eval { $dom->at('.album-meta-artist')->all_text =~ s/[\r\n]//gr } || '';
  my $album  = eval { $dom->at('.album-meta-title' )->all_text =~ s/[\r\n]//gr } || '';
 
  return {
    title   => join(' - ', trim $artist, trim $album),
    url     => trim $url,
  }
}

1;