use Test::Most;
use FeedMe::Metadata::Spotify;
use Data::Dumper;

BEGIN { 
  use_ok 'FeedMe::Metadata::Spotify';
}

my $spotify = new_ok 'FeedMe::Metadata::Spotify';
$spotify->api->trace(1);
my $result = $spotify->get_album_info('Nils Bech', 'Echo');
warn Dumper $result;

done_testing();