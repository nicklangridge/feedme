use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use Method::Signatures;
use Data::Dumper;
use Getopt::Long;
use Parallel::ForkManager;
use FeedMe::Metadata::Spotify;
use FeedMe::Model 'model';
use FeedMe::Metadata::Mercury;
use FeedMe::Config qw(config);

GetOptions (
  'p|print'     => \my $print,
  'v|verbose'   => \my $verbose, 
  'w|workers=n' => \(my $workers = 5),
);

my @slugs = @ARGV;
my @feeds = model->feed->fetch_active;

if (@slugs) {
  # keep only the feeds specified by slugs
  @feeds = grep {my $feed = $_; grep {$feed->{slug} eq $_} @slugs} @feeds;
  
  if (!@feeds) {
    say 'No active feeds match your input';
    exit;
  }
}

my $spotify = FeedMe::Metadata::Spotify->new(
  client_id     => config->{spotify_client_id},
  client_secret => config->{spotify_client_secret},
);

my $mercury;
if (config->{mercury_api_key}) {
  $mercury = FeedMe::Metadata::Mercury->new(api_key => config->{mercury_api_key});
}

my @reviews = main->get_all_reviews(@feeds);

my $created = { artist => 0, album => 0, review => 0 };

main->process_review($_) for @reviews;

for (keys %$created) {
  say "created $created->{$_} ${_}s";
}

say "done";

exit 0;

#-------------------------------------------------------------------------------

method process_review ($review_info) {
  say "$review_info->{artist} - $review_info->{album} [$review_info->{source}]";
  
  my $album_info = $spotify->get_album_info(
    $review_info->{artist}, 
    $review_info->{album}
  );
  
  if (!$album_info->{name}) {
    say "  not found in Spotify";
    return;
  }
  
  say "  found in Spotify";
  
  my $artist = model->artist->fetch_or_create({
    uri  => $album_info->{artist_uri},
    name => $album_info->{artist},
  });
  
  say "  artist " . ($artist->{_created} ? '<-- created' : '');
  
  $created->{artist} ++ if $artist->{_created};
  
  my $album = model->album->fetch_or_create({
    uri       => $album_info->{uri},
    name      => $album_info->{name},
    image     => $album_info->{image},
    keywords  => join (' ', $album_info->{artist_name}, $album_info->{name}),
    regions   => $album_info->{regions},
    genres    => $album_info->{genres},
    artist_id => $artist->{artist_id},
  });
  
  $created->{album} ++ if $album->{_created};
  
  say "  album " . ($album->{_created} ? '<-- created' : '');
  
  my $review = model->review->fetch_or_create({
    album_id  => $album->{album_id},
    feed_id   => $review_info->{feed_id},
    url       => $review_info->{url},
    snippet   => $review_info->{snippet},
  });
  
  $created->{review} ++ if $review->{_created};
  
  say "  review " . ($review->{_created} ? '<-- created' : '');
  
  if ($review->{_created} && $review->{snippet}) {
    say "    snippet '$review->{snippet}'";
  }
  
  if (!$review->{snippet} && $mercury) {
    $review->{snippet} = $mercury->excerpt($review->{url});
    say "    mercury snippet '$review->{snippet}'";
    model->review->save($review) if $review->{snippet};
  }
}

method get_all_reviews (@feeds!) {
  # fetch all reviews, using parallel workers
  my $pm = Parallel::ForkManager->new($workers);
  my @reviews;
    
  $pm->run_on_finish (sub {
    my $data = pop @_;
    push @reviews, @$data;
  });
  
  foreach my $feed (@feeds) {
    $pm->start and next; # fork
    my @r = model->feed->fetch_reviews($feed);
    say "$feed->{slug}:" . scalar(@r);  
    $pm->finish(0, \@r);
  }
  
  $pm->wait_all_children;
  
  return @reviews;
}