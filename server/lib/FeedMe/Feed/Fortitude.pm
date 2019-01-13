package FeedMe::Feed::Fortitude;
use Moo;
use Method::Signatures;
use Text::Trim;
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::XML';

sub name         { 'Fortitude' };
sub url          { 'http://www.fortitudemagazine.co.uk/feed/' };
sub homepage_url { 'http://www.fortitudemagazine.co.uk' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
    $title =~ s/(\x{2018}|\x{2019})//g; # strip quote chars
  $title =~ /EP Review:\s+(.+?)\s+(?:\x{2013}|\x{2014}|-|–)\s+(.+)/;
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