use Test::Most;

BEGIN { 
  use_ok 'FeedMe::DB', qw(db);
}

isa_ok db->feeds, 'FeedMe::DB::Feeds', 'feeds';

done_testing();