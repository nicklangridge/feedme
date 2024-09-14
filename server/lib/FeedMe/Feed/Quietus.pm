package FeedMe::Feed::Quietus;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub name         { 'The Quietus' };
sub url          { 'https://thequietus.com/feed' };
sub homepage_url { 'https://thequietus.com' };

#method extract_artist_and_album ($title) {
#  print "T: $title\n";
#  $title =~ s/\s+/ /g;
#  $title =~ /(.+?)\s+(?:\x{2013}|\x{2014}|-)\s+(?:<i>|&lt;i&gt;)?(.+)(?:<\/i>|&lt;\/i&gt;)/;  
#  return {
#    artist => trim $1, 
#    album  => trim $2
#  };
#}

1;
