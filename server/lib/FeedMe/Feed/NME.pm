package FeedMe::Feed::NME;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub name         { 'NME' };
sub url          { 'http://www.nme.com/reviews/feed/' };
sub homepage_url { 'http://www.nme.com' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
  $title =~ /(.+?)\s+(?:\x{2013}|\x{2014}|-|–)\s+\x{2018}(.+)\x{2019}/;
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

1;