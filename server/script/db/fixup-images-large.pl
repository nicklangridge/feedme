#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;
use Data::Dumper;

use FeedMe::Model 'model';
use FeedMe::Metadata::Spotify;

my $spotify = FeedMe::Metadata::Spotify->new({debug=>1});

my @albums = model->album->fetch_where({ image => undef });

foreach my $album (@albums) {
  
  say "$album->{album_id} : $album->{name}";
  
  my $album_info = $spotify->_fetch('album',  $spotify->_get_id('album', $album->{uri}));
  #say Dumper $album_info->{images};
  my $image      = $spotify->_get_image($album_info->{images}, 640) || $spotify->_get_image($album_info->{images}, 300);
  
  say "Found image: $image";
  
  if ($image) {
    $album->{image} = $image;
    model->album->save($album);
  }
}
