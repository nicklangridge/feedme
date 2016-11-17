use Test::Most;

BEGIN { 
  use_ok 'FeedMe::Model', qw(model);
}

isa_ok api->feeds, 'FeedMe::Model::Feed', 'feed';

done_testing();