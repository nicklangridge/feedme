package FeedMe::Feed::TapeFear;
use Moo;
with 'FeedMe::Role::Feed::XML';

sub name         { 'TapeFear' };
sub url          { 'http://feeds.feedburner.com/TapeFear' };
sub homepage_url { 'http://www.tapefear.com' };

1;