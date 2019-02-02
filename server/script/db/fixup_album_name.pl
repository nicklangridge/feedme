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

my @rows = dbh->query('SELECT * FROM album WHERE name != CONVERT(BINARY CONVERT(name USING latin1) USING utf8)')->hashes;

say 'found ' . scalar(@rows) . ' albums with special chars';

foreach my $row (@rows) {
  say ;
  my $album = $spotify->_fetch('album', $spotify->_get_id('album', $row->{uri}));
  say "$row->{album_id} $row->{name} --> $album->{name}";
  dbh->query('UPDATE album SET name = ?, slug = ? WHERE album_id = ?', $album->{name}, slug($album->{name}), $row->{album_id});
}

say "done";

exit 0;

