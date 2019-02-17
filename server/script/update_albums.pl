#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use Method::Signatures;
use Data::Dumper;
use Getopt::Long;
use FeedMe::Metadata::Spotify;
use FeedMe::Model 'model';
use FeedMe::Utils::Log qw(yay info warning);
use Date::Time;

GetOptions (
  'v|verbose'   => \my $verbose, 
  'new=i'       => \(my $new_limit = 50),
  'old=i'       => \(my $old_limit = 100),
);
$verbose ||= 0; # ensure defined

my $spotify = FeedMe::Metadata::Spotify->new;

info '===== Updating albums [' . DateTime->now . '] =====';

if ($new_limit) {
  my @albums = model->album->fetch_newest($new_limit);

  info sprintf 'Checking %s newest albums...', scalar @albums;

  foreach my $album (@albums) { 
    info "  NEW: $album->{slug} [$album->{album_id}]";
    main->update_album($album);
  }
}

if ($old_limit) { 
 my @albums = model->album->fetch_for_update($old_limit);

  info sprintf 'Checking %s old albums...', scalar @albums;

  foreach my $album (@albums) { 
    info "  OLD: $album->{slug} (last check $album->{checked})";
    main->update_album($album);
  }
}

say "done";

exit 0;

#-------------------------------------------------------------------------------

method update_album ($album!) {
  
  my $album_id  = $album->{album_id};
  my $artist    = model->artist->fetch_by_id($album->{artist_id});
  my $new       = $spotify->get_album_info( $artist->{name}, $album->{name} ) ;
  
  if (!$new or !keys %$new) {
    warning "    no result from spotify for $artist->{name} - $album->{name}";
    warning "    artist $artist->{name} [$artist->{artist_id}]";
    warning "    $album->{uri}" . ' -- ' . $spotify->_get_id('album', $album->{uri});
    warning "    $artist->{uri}";
    
    my $al = $spotify->_fetch('album', $spotify->_get_id('album', $album->{uri}));
    warning  "    new al $al->{name}"; 
    my $ar = $spotify->_fetch('artist', $spotify->_get_id('artist', $artist->{uri}));
    warning  "    new ar $ar->{name}"; 


    return;
  }  

  #push @{ $new->{genres} }, model->musicstory->fetch_artist_genres($artist->{name});  

  my $genres_updated = model->album->set_genres($album_id, $new->{genres});
  yay '    genres updated'  if $genres_updated;
    
  my $regions_updated = model->album->set_regions($album_id, $new->{regions});
  yay '    regions updated' if $regions_updated; 
  
  #say '  no updates' unless ($genres_updated or $regions_updated);
  
  $album->{checked} = \"now()";
  model->album->save($album);
}
