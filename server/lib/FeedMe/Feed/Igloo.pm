package FeedMe::Feed::Igloo;
use Moo;
use Method::Signatures;
use Text::Trim;
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::XML';

sub name         { 'Igloo' };
sub url          { 'https://igloomag.com/category/reviews/feed' };
sub homepage_url { 'https://igloomag.com/' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
  $title =~ /(.+?)\s*\:\:\s+([^\(\)]+)(\s+\(.+\))?/i;  
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

method parse_entry ($entry) {
  return {
    title       => trim $entry->title,
    url         => trim $entry->link,
    description => snippet($entry->content->body, 200),
  }
}


1;
