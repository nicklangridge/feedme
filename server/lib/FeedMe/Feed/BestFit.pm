package FeedMe::Feed::BestFit;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::DOM';

sub name         { 'The Line of Best Fit' };
sub url          { 'https://www.thelineofbestfit.com/albums' };
sub homepage_url { 'https://www.thelineofbestfit.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  @urls = map { "$_" } grep {$_ =~ /.*www\..*\/albums\/[^\/]+$/} @urls;
  return @urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html   = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom    = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $artist = eval { $dom->at('div[class="uppercase"]')->all_text =~ s/[\r\n]//gr } || '';
  my $album  = eval { $dom->at('h2' )->all_text =~ s/[\r\n]//gr } || ''; 
  $album =~ s/^"//;
  $album =~ s/"$//;
  my $description = eval { $dom->at('h1' )->all_text =~ s/[\r\n]//gr } || '';
  return {
    title       => join(' - ', trim $artist, trim $album),
    url         => trim $url,
    description => snippet($description, 200), 
  }
}

1;
