package FeedMe::Feed::GigSoup;
use Moo;
use Method::Signatures;
use Text::Trim;
use FeedMe::Utils::Snippet qw(snippet);

with 'FeedMe::Role::Feed::XML';

sub name         { 'Gig Soup' };
sub url          { 'http://www.gigsoupmusic.com/category/reviews/album-reviews/feed/' };
sub homepage_url { 'http://www.gigsoupmusic.com' };

method extract_artist_and_album ($title) {
  $title =~ /(.+)\s+\x{2018}(.+)\x{2019}/;
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

method parse_entry ($entry) {
  my $snippet = snippet($entry->content->body, 300);
  $snippet =~ s/(.+[Impact|Votes?]\s+\d+\s+\d+)//i;
  
  return {
    title       => trim $entry->title,
    url         => trim $entry->link,
    description => snippet($snippet, 200), 
  }
}

1;