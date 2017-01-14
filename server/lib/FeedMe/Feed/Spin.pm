package FeedMe::Feed::Spin;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub name         { 'Spin' };
sub url          { 'http://www.spin.com/new-music/feed/' };
sub homepage_url { 'http://www.spin.com' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
  $title =~ s/(\x{201c}|\x{201d})//g; # strip quote chars
  $title =~ /New Music:\s+(.+?)\s+(?:\x{2013}|\x{2014}|-|–)\s+(.+)/;
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

1;