#!/usr/bin/env perl

use strict;
use feature 'say';
use lib 'lib';
use Method::Signatures;
use Data::Dumper;
use Module::Loader;
use Getopt::Long;
use FeedMe::MySQL qw(dbh);

GetOptions (
  'feed_id=i'    => \(my $feed_id),
  'artist_id=i'  => \(my $artist_id),
  'album_id=i'   => \(my $album_id),
  'dry=i'        => \(my $dry = 1),
  'tidy'         => \(my $tidy),
);

say '*** DRY RUN ***' if $dry;

if ($artist_id) {
  main->delete_artist($artist_id);
} elsif ($album_id) {
  main->delete_album($album_id);
} elsif ($feed_id) {
  main->delete_feed_reviews($feed_id)
}

if ($tidy) {
  main->tidy; 
} 

say 'done';
say '*** DRY RUN ***' if $dry;

exit;

method delete_feed_reviews ($feed_id!) {
  
  say "Deleting reviews for feed $feed_id";
  
  my @reviews = dbh->query('SELECT * FROM review WHERE feed_id = ?', $feed_id)->hashes;
  foreach (@reviews) {
    main->log_query('DELETE FROM review WHERE review_id = ?', $_->{review_id});
  } 
}


method delete_artist ($artist_id!) {
  
  say "Deleting artist $artist_id and related albums";
  
  my @albums = dbh->query('SELECT * FROM album WHERE artist_id = ?', $artist_id)->hashes;
  
  foreach my $album (@albums) {
    main->delete_album($album->{album_id});
  }
  
  main->log_query('DELETE FROM artist WHERE artist_id = ?', $artist_id);
}

method delete_album ($album_id!) {
  
  my ($album) = dbh->query('SELECT * FROM album WHERE album_id = ?', $album_id)->hashes;
  
  if (!$album) {
    say "Could not delete album $album_id - does not exist";
    return;
  }
  
  say "Deleting album $album_id";
  
  foreach (
    'DELETE FROM album_region WHERE album_id = ?',
    'DELETE FROM album_genre WHERE album_id = ?',
    'DELETE FROM album_review WHERE album_id = ?',
    'DELETE FROM album WHERE album_id = ?',
  ) {
    main->log_query($_, $album_id);
  }
}

method tidy {
  say 'Tidying up...';
  
  say 'Deleting artists with no albums (if any)...';
  my @artists = dbh->query('SELECT * FROM artist WHERE artist_id NOT IN (SELECT artist_id FROM album)')->hashes;
  foreach (@artists) {
    main->log_query('DELETE FROM artist WHERE artist_id = ?', $_->{artist_id});
  }

  say 'Deleting albums with no artist (if any)...';
  my @albums = dbh->query('SELECT * FROM album WHERE artist_id NOT IN (SELECT artist_id FROM artist)')->hashes;
  foreach (@albums) {
    main->log_query('DELETE FROM album WHERE album_id = ?', $_->{album_id});
  }

  say 'Deleting albums with no reviews (if any)...';
  my @albums = dbh->query('SELECT * FROM album WHERE album_id NOT IN (SELECT album_id FROM review)')->hashes;
  foreach (@albums) {
    main->log_query('DELETE FROM album WHERE album_id = ?', $_->{album_id});
  }
  
  say 'Deleting oprhaned reviews (if any)...';
  my @reviews = dbh->query('SELECT * FROM review WHERE album_id NOT IN (SELECT album_id FROM album)')->hashes;
  foreach (@reviews) {
    main->log_query('DELETE FROM review WHERE review_id = ?', $_->{review_id});
  }
  
  say 'Deleting oprhaned album_regions (if any)...';
  my @regions = dbh->query('SELECT * FROM album_region WHERE album_id NOT IN (SELECT album_id FROM album)')->hashes;
  foreach (@regions) {
    main->log_query('DELETE FROM album_region WHERE album_id = ?', $_->{album_id});
  }

}

method log_query ($q, @args) {
  say sprintf "  %s [%s]", $q, join(', ', @args);
  dbh->query($q, @args) unless $dry;
}