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
use FeedMe::Config qw(config);

GetOptions (
  'p|print'     => \my $print,
  'v|verbose'   => \my $verbose, 
);

my $spotify = FeedMe::Metadata::Spotify->new(
  client_id     => config->{spotify_client_id},
  client_secret => config->{spotify_client_secret},
);


my @albums = model->album->fetch_newest(50);

say sprintf '>>> Checking %s newest albums...', scalar @albums;

foreach my $album (@albums) { 
  say "NEW: $album->{slug}";
  main->update_album($album);
}

@albums = model->album->fetch_for_update(100);

say sprintf '>>> Checking %s old albums...', scalar @albums;

foreach my $album (@albums) { 
  say "OLD: $album->{slug}";
  say "  last checked $album->{checked}";
  main->update_album($album);
}


say "done";

exit 0;

#-------------------------------------------------------------------------------

method update_album ($album!) {
  
  my $album_id = $album->{album_id};
  my $new      = eval { $spotify->get_album_info( $album->{uri} ) };  
  
  if (!$new or !keys %$new) {
    say '  no result from spotify';
    return;
  }  
  
  my $genres_updated = model->album->set_genres($album_id, $new->{genres});
  say '  genres updated'  if $genres_updated;
    
  my $regions_updated = model->album->set_regions($album_id, $new->{regions});
  say '  regions updated' if $regions_updated;
  
  say '  no updates' unless ($genres_updated or $regions_updated);
  
  $album->{checked} = \"now()";
  model->album->save($album);
}
