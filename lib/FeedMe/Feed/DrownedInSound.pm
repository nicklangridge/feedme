package FeedMe::Feed::DrownedInSound;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub name         { 'Drowned In Sound' };
sub url          { 'http://dis11.herokuapp.com/feed/index' };
sub homepage_url { 'http://drownedinsound.com' };

1;