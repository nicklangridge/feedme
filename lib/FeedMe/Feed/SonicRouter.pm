package FeedMe::Feed::SonicRouter;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub url { 'http://www.sonicrouter.com/category/reviews/feed/' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
  $title =~ /(?:.+\:)(.+?)\s+(?:\x{2013}|\x{2014}|-)\s+(.+)(\[.+\])$/;   
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

1;