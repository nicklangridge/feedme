#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use Data::Dumper;
use FeedMe::Metadata::Spotify;
use FeedMe::MySQL qw(dbh);
use FeedMe::Utils::Slug qw(slug);

my $spotify = FeedMe::Metadata::Spotify->new;

my @rows = dbh->query('SELECT * FROM artist WHERE name != CONVERT(BINARY CONVERT(name USING latin1) USING utf8)')->hashes;

say 'found ' . scalar(@rows) . ' artits with broken utf-8 encoding';

foreach my $row (@rows) {
  say ;
  my $artist = $spotify->_fetch('artist', $spotify->_get_id('artist', $row->{uri}));
  say "$row->{artist_id} $row->{name} --> $artist->{name}";
  dbh->query('UPDATE artist SET name = ?, slug = ? WHERE artist_id = ?', $artist->{name}, slug($artist->{name}), $row->{artist_id});
}

say "done";

exit 0;

