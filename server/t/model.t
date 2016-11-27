use Test::Most;

BEGIN { 
  use_ok 'FeedMe::Model', qw(model);
}

isa_ok model->feed,   'FeedMe::Model::Feed',   'feed';
isa_ok model->album,  'FeedMe::Model::Album',  'album';
isa_ok model->artist, 'FeedMe::Model::Artist', 'artist';

done_testing();