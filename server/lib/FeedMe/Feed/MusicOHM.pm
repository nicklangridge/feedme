package FeedMe::Feed::MusicOHM;
use Moo;
use Method::Signatures;
use Text::Trim;
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::XML';

sub name         { 'MusicOHM' };
sub url          { 'https://www.musicomh.com/reviews/albums/feed' };
sub homepage_url { 'https://www.musicomh.com' };

method parse_entry ($entry) {
  return {
    title       => trim $entry->title,
    url         => trim $entry->link,
    description => snippet($entry->content->body, 200),
  }
}


1;
