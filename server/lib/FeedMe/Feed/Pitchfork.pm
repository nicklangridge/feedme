package FeedMe::Feed::Pitchfork;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub name         { 'Pitchfork' };
sub url          { 'http://pitchfork.com/rss/reviews/albums/' };
sub homepage_url { 'http://pitchfork.com' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
  $title =~ /(.+?)\s*\:\s+(.+)/;  
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

1;