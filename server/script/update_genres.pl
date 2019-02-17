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
use DateTime;

info '===== Updating genres [' . DateTime->now . '] =====';

my @parents = model->genres->parent_genres;

info "Parent genres: " . scalar(@parents);

foreach my $parent (@parents) {
  yay "$parent";
  
  my @sub_genres = model->genres->sub_genres($parent);
  
  info "  Sub genres: " . scalar(@sub_genres);
  
  my $in = "'" . join("' ,'", @sub_genres) . "'";
  dbh->query("UPDATE album_genre SET parent = ? WHERE slug IN ($in)", $parent);
  
  my $albums = dbh->query("SELECT COUNT(DISTINCT album_id) FROM album_genre WHERE parent = ?", $parent)->flat;
  info "  Albums: " . $albums->[0];
}

