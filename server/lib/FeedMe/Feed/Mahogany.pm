package FeedMe::Feed::Mahogany;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub name         { 'Mahogany' };
sub url          { 'http://wearemahogany.com/feed/' };
sub homepage_url { 'http://wearemahogany.com' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
  
  $title =~ /(.+)\s+releases\s+(.+)/;
  return { artist => trim $1, album => trim $2 } if $1 and $2;

  $title =~ /Brand New:(.+)\s+\x{2018}(.+)\x{2019}/i; 
  return { artist => trim $1, album => trim $2};
}

1;