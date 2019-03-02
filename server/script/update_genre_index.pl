#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use Method::Signatures;
use FeedMe::MySQL qw(dbh);
use FeedMe::Utils::Log qw(yay info warning);
use DateTime;

info '===== Updating genre index [' . DateTime->now . '] =====';

my @genres = dbh->query("SELECT name, slug, count(*) AS occurances FROM album_genre GROUP BY name")->hashes;
foreach my $genre (@genres) {
  
  my @words = split /[\s-]/, $genre->{name}; 
  
  dbh->query(
    "INSERT INTO genre_index (name, slug, occurances, word1, word2, word3) values (?, ?, ?, ?, ?, ?)
     ON DUPLICATE KEY UPDATE occurances = values(occurances)", 
    $genre->{name},
    $genre->{slug},
    $genre->{occurances},
    $words[0],
    $words[1],
    $words[2],
  );
}
