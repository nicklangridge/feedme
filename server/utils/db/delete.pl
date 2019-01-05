use strict;
use feature 'say';
use lib 'lib';
use Method::Signatures;
use Data::Dumper;
use Module::Loader;
use Getopt::Long;
use FeedMe::MySQL qw(dbh);

GetOptions (
  'artist_id=i' => \(my $artist_id = undef),
  'album_id=i'  => \(my $album_id = undef),
  'dry=i'       => \(my $dry = 1),
);

say 'DRY RUN...' if $dry;

if ($artist_id) {
  main->delete_artist($artist_id);
} elsif ($album_id) {
  main->delete_album($album_id);
} else {
  say 'Nothing to do';
}

method delete_artist ($artist_id!) {
  
  say "Deleting artist $artist_id and related albums";
  
  my @albums = dbh->query('SELECT * FROM album WHERE artist_id = ?', $artist_id)->hashes;
  
  foreach my $album (@albums) {
    main->delete_album($album->{album_id});
  }
  
  main->query('DELETE FROM artist WHERE artist_id = ?', $artist_id);
}

method delete_album ($album_id!) {
  
  say "Deleting album $album_id";
  
  foreach (
    'DELETE FROM album_region WHERE album_id = ?',
    'DELETE FROM album_genre WHERE album_id = ?',
    'DELETE FROM album_review WHERE album_id = ?',
    'DELETE FROM album WHERE album_id = ?',
  ) {
    main->query($_, $album_id);
  }
  
}

method query ($q, @args) {
  say sprintf "  %s [%s]", $q, join(', ', @args);
  dbh->query($q, @args) unless $dry;
}