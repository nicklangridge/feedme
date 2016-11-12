package FeedMe::Feed::TLOBF;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;
use feature 'say';

with 'FeedMe::Role::Feed::XML';

sub url { 'https://www.thelineofbestfit.com/feed/albums.rss' };

method parse_entry ($entry) {
  my $html = $self->_get($entry->link) || die "Failed to fetch page [" . $entry->link . "]: $!\n";
  my $dom  = Mojo::DOM->new($html)     || die "Failed to parse html: $!\n";

  say $entry->link; 
  
  my $artist = eval { $dom->at('.album-meta-artist')->all_text };
  my $album  = eval { $dom->at('.album-meta-title')->all_text };
  $artist =~ s/[\r\n]//g;
  $album =~ s/[\r\n]//g;

  my $title = join ' - ', trim $artist, trim $album;
  say $title;
 
  return {
    title   => $title,
    url     => trim $entry->link,
    #content => trim $entry->content->body,
  }
}

1;