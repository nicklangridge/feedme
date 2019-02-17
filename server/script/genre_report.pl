#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use Method::Signatures;
use FeedMe::MySQL qw(dbh);
use FeedMe::Model 'model';
use FeedMe::Utils::Log qw(yay info warning);
use Getopt::Long;

GetOptions (
  'v|verbose'   => \my $verbose, 
);
$verbose ||= 0; # ensure defined

info "\n----- Summary -----";

my @parents           = model->genres->parent_genres;
my @model_genres      = model->genres->all_genres;
my @db_genres         = @{ dbh->query("SELECT DISTINCT slug FROM album_genre")->flat };
my $total_albums      = dbh->query("SELECT COUNT(*) FROM album")->flat->[0];
my $albums_with_genre = dbh->query("SELECT COUNT(DISTINCT album_id) FROM album_genre")->flat->[0];
my $without_parent    = dbh->query("SELECT COUNT(DISTINCT album_id) FROM album_genre WHERE album_id NOT IN (SELECT album_id FROM album_genre WHERE parent IS NOT NULL)")->flat->[0];

info "Parent genres:      " . scalar(@parents);
info "Model genres:       " . scalar(@model_genres);
info "Db genres:          " . scalar(@db_genres);
info "Total albums:       " . $total_albums;
info "  without genre:    " . ($total_albums - $albums_with_genre);
info "  with genre:       " . $albums_with_genre;
info "    without parent: " . $without_parent; 

info "\n----- Breakdown by parent -----";

foreach my $parent (@parents) {
  yay "$parent";
  my @sub_genres = model->genres->sub_genres($parent);  
  info "  Sub genres: " . scalar(@sub_genres);
  my $albums = dbh->query("SELECT COUNT(DISTINCT album_id) FROM album_genre WHERE parent = ?", $parent)->flat;
  info "  Albums: " . $albums->[0];
}

if ($verbose) {
  info "\n----- Genres without parent -----";
  
  my @rows = @{ dbh->query("SELECT slug, COUNT(*) as num FROM album_genre GROUP BY name ORDER BY num")->hashes };
  
  foreach my $row (@rows) {
    if (!model->genres->parent_lookup->{$row->{slug}}) {
      info "$row->{num}  $row->{slug}";
    }
  }
}