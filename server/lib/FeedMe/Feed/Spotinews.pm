package FeedMe::Feed::Spotinews;
use Moo;
with 'FeedMe::Role::Feed::XML';

sub name         { 'Spotinews' };
sub url          { 'https://spotinews.wordpress.com/feed' };
sub homepage_url { 'https://spotinews.wordpress.com' };

1;