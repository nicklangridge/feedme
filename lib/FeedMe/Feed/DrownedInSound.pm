package FeedMe::Feed::DrownedInSound;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub url { 'http://dis11.herokuapp.com/feed/index' };

1;