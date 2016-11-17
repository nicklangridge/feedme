package FeedMe::Feed::BestFit;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub name         { 'The Line of Best Fit' };
sub url          { 'https://www.thelineofbestfit.com/feed/albums.rss' };
sub homepage_url { 'https://www.thelineofbestfit.com' };

method parse_entry ($entry) {
  # we only want album reviews
  return {} unless $entry->link =~ /reviews\/albums/;
  
  # pick out the artist and album name from the html of the article
  my $html   = $self->_get($entry->link) || die "Failed to fetch page [" . $entry->link . "]: $!\n";
  my $dom    = Mojo::DOM->new($html)     || die "Failed to parse html: $!\n";  
  my $artist = eval { $dom->at('.album-meta-artist')->all_text =~ s/[\r\n]//gr } || '';
  my $album  = eval { $dom->at('.album-meta-title' )->all_text =~ s/[\r\n]//gr } || '';
 
  return {
    title   => join(' - ', trim $artist, trim $album),
    url     => trim $entry->link,
  }
}

1;