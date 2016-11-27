package FeedMe::Feed::Clash;
use Moo;
with 'FeedMe::Role::Feed::XML';

sub name         { 'Clash' };
sub url          { 'http://www.clashmusic.com/reviews/feed' };
sub homepage_url { 'http://www.clashmusic.com' };

1;