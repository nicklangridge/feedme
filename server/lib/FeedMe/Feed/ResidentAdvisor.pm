package FeedMe::Feed::ResidentAdvisor;
use Moo;
with 'FeedMe::Role::Feed::XML';

sub name         { 'Resident Advisor' };
sub url          { 'https://www.residentadvisor.net/xml/review-album.xml' };
sub homepage_url { 'https://www.residentadvisor.net' };

1;