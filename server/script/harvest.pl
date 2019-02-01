#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use utf8::all;
use feature 'say';

use Method::Signatures;
use Data::Dumper;
use Getopt::Long;
use Parallel::ForkManager;
use FeedMe::Metadata::Spotify;
use FeedMe::Model 'model';
use FeedMe::MySQL qw(dbh);
use FeedMe::Metadata::Mercury;
use FeedMe::Config qw(config);
use FeedMe::Utils::Log qw(yay info warning);

GetOptions (
  'v|verbose'   => \my $verbose, 
  'w|workers=n' => \(my $workers = 5),
);
$verbose ||= 0; # ensure defined

my @slugs = @ARGV;
my @feeds = model->feed->fetch_active;

if (@slugs) {
  # keep only the feeds specified by slugs
  @feeds = grep {my $feed = $_; grep {$feed->{slug} eq $_} @slugs} @feeds;
  
  if (!@feeds) {
    info 'No active feeds match your input';
    exit;
  }
}

my $spotify = FeedMe::Metadata::Spotify->new;

my $mercury;
if (config->{mercury_api_key}) {
  $mercury = FeedMe::Metadata::Mercury->new;
}

info "Processing " . scalar(@feeds) . " feeds...";

my @reviews = main->get_all_reviews(@feeds);

my $created = { artist => 0, album => 0, review => 0 };

info "Processing " . scalar(@reviews) . " reviews...";

main->process_review($_) for @reviews;

for (qw(artist album review)) {
  info "created $created->{$_} ${_}s";
}

info "done";

exit 0;

#-------------------------------------------------------------------------------

method process_review ($review_info) {
  
  my $title = "[$review_info->{source}] $review_info->{artist} - $review_info->{album}";

  if (model->review->fetch_by_url($review_info->{url})) {
    info "$title ====> review exists", $verbose;
    return;
  }
  
  my $album_info = $spotify->get_album_info(
    $review_info->{artist}, 
    $review_info->{album}
  );
  
  if (!$album_info->{name}) {
    warning "$title ====> not found in Spotify", $verbose;
    return;
  }
  
  if ($album_info->{album_type} eq 'single') {
    warning "$title ====> is a single, skipping", $verbose;
    return;
  }
  
  yay "$title ====> found in Spotify";
  
  my $artist = model->artist->fetch_or_create({
    uri  => $album_info->{artist_uri},
    name => $album_info->{artist_name},
  });
  
  if ($artist->{_created}) {
    yay "  >>> artist created";
    $created->{artist} ++ ;
    
    #push @{ $album_info->{genres} }, model->musicstory->fetch_artist_genres($artist->{name});
  }
    
  my $album = model->album->fetch_or_create({
    uri       => $album_info->{uri},
    name      => $album_info->{name},
    image     => $album_info->{image},
    keywords  => join (' ', $album_info->{artist_name}, $album_info->{name}),
    regions   => $album_info->{regions},
    genres    => $album_info->{genres},
    artist_id => $artist->{artist_id},
  });
  
  if ($album->{_created}) {
    yay "  >>> album created";
    $created->{album} ++ 
  }
  
  my $review = model->review->fetch_or_create({
    album_id  => $album->{album_id},
    feed_id   => $review_info->{feed_id},
    url       => $review_info->{url},
    snippet   => $review_info->{snippet},
  });

  if ($review->{_created}) {
    yay "  >>> review created";
    $created->{review} ++; 
    
    if ($review->{snippet}) {
      yay "    >>> snippet '$review->{snippet}'";
    } elsif ($mercury) {
      $review->{snippet} = $mercury->excerpt($review->{url});
      yay "    >>> mercury snippet '$review->{snippet}'";
      model->review->save($review) if $review->{snippet};
    }
  } else {
    warning "  >>> review is duplicate, skipping";
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
    info "$feed->{slug} " . scalar(@r);  
    $pm->finish(0, \@r);
  }
  
  $pm->wait_all_children;
  
  return @reviews;
}