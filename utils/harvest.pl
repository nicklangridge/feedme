use strict;
use warnings;
use feature 'say';
use lib 'lib';

use Method::Signatures;
use Data::Dumper;
use Getopt::Long;
use Parallel::ForkManager;
use FeedMe::Metadata::Spotify;
use FeedMe::Model 'model';

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

my $spotify = FeedMe::Metadata::Spotify->new;

my @reviews = main->get_all_reviews(@feeds);

main->process_review($_) for @reviews;

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
    name => $album_info->{artist_name},
  });
  
  say "  artist " . ($artist->{_created} ? '<-- created' : '');
  
  my $album = model->album->fetch_or_create({
    uri       => $album_info->{uri},
    name      => $album_info->{name},
    image     => $album_info->{image},
    regions   => $album_info->{regions},
    genres    => $album_info->{genres},
    artist_id => $artist->{artist_id},
  });
  
  say "  album " . ($album->{_created} ? '<-- created' : '');
  
  my $review = model->review->fetch_or_create({
    album_id  => $album->{album_id},
    feed_id   => $review_info->{feed_id},
    url       => $review_info->{url},
  });
  
  say "  review " . ($review->{_created} ? '<-- created' : '');
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