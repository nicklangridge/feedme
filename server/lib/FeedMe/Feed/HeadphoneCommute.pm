package FeedMe::Feed::HeadphoneCommute;
use Moo;
use Method::Signatures;
use Text::Trim;
with 'FeedMe::Role::Feed::XML';

sub name         { 'Headphone Commute' };
sub url          { 'https://reviews.headphonecommute.com/feed' };
sub homepage_url { 'https://reviews.headphonecommute.com' };

method extract_artist_and_album ($title) {
  $title =~ s/(\s+\(.+\))$//;
  $title =~ /(?:[A-Z\s]+\s+:\s+)?(.+?)\s+(?:\x{2013}|\x{2014}|-|–)\s+(.+)/;
  return {
    artist => trim $1, 
    album  => trim $2
  };
}


1;