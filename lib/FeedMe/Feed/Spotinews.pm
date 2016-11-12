package FeedMe::Feed::Spotinews;
use Moo;
with 'FeedMe::Role::Feed::XML';

sub url { 'https://spotinews.wordpress.com/feed' };

1;