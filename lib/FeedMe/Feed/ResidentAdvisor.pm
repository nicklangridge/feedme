package FeedMe::Feed::ResidentAdvisor;
use Moo;
with 'FeedMe::Role::Feed::XML';

sub url { 'https://www.residentadvisor.net/xml/review-album.xml' };

1;