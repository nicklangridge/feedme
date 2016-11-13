use Test::Most;
use FeedMe::Metadata::LastFM;
use FeedMe::Config qw(config);

my @ARTISTS = (
  ['Madonna', 'https://www.last.fm/music/Madonna', 'pop'],
  ['Al Green', 'https://www.last.fm/music/Al+Green', 'soul'],
);

my $lastfm = new_ok 'FeedMe::Metadata::LastFM', [ %{config->{lastfm_params}} ];

foreach (@ARTISTS) {
  my ($artist, $url, $tag) = @$_;

  my $info = $lastfm->artist_info($artist);

  #warn dump $info;

  ok $info, "got info for $artist";
  ok length $info->{bio} > 0, 'got some bio text';
  is $info->{bio_source}, 'last.fm', 'got expected bio site';
  is $info->{bio_url}, $url, 'got expected bio url';
  isa_ok $info->{tags}, 'ARRAY', 'tags';
  ok scalar( grep {/^$tag$/} @{$info->{tags}} ), 'tags array contains expected tag';
}

my $info = $lastfm->artist_info('NoArtistWithThisName');
is_deeply $info, {}, "empty hashref returned if info not found";

done_testing();