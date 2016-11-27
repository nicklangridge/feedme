use Test::Most;
use FeedMe::Metadata::Spotify;

BEGIN { 
  use_ok 'FeedMe::Metadata::Spotify';
}

my $spotify = new_ok 'FeedMe::Metadata::Spotify';

#$spotify->api->trace(1);

my @ALBUMS = (
  ['Nils Bech', 'Echo'],
  ['Al Green', 'Lay It Down'],
);

foreach (@ALBUMS) {
  my ($artist, $album) = @$_;
  
  my $info = $spotify->get_album_info($artist, $album);
  
  ok $info, "got info for $artist - $album";
  is $info->{name}, $album, 'got expected album name';
  is $info->{artist_name}, $artist, 'got expected artist name';
  ok $info->{uri} =~ /^spotify:album/, 'got an album uri';
  ok $info->{artist_uri} =~ /^spotify:artist/, 'got an artist uri';
  ok $info->{image} =~ /^https:\/\//, 'got an image url';
  isa_ok $info->{regions}, 'ARRAY', 'regions';
  isa_ok $info->{genres}, 'ARRAY', 'genres';
}

my $info = $spotify->get_album_info('nothing_by_this_name', 'nothing_by_this_name');
is_deeply $info, {}, "empty hashref returned if info not found";


done_testing();