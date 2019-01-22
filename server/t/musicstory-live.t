use Test::Most;
use FeedMe::Metadata::MusicStory;

BEGIN { 
  use_ok 'FeedMe::Metadata::MusicStory';
}

my $musicstory = new_ok 'FeedMe::Metadata::MusicStory';

#$musicstory->trace(1);

my @ARTISTS = (
  ['Nils Bech', ['Electro']],
  ['Al Green',  ['Reggae music', 'World music']],
);

foreach (@ARTISTS) {
  my ($artist, $genres) = @$_;
  my @got_genres = $musicstory->get_artist_genres($artist);
  is_deeply $genres, [@got_genres], 'get_artist_genres';    
}

my @got_genres = $musicstory->get_artist_genres('nothing_by_this_name');
is_deeply [], [@got_genres], "empty array returned if artist not found";

done_testing();