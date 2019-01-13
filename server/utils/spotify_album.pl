use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use Data::Dumper;
use Getopt::Long;
use FeedMe::Metadata::Spotify;

GetOptions (
  'id=s'     => \my $id,
  'uri=s'    => \my $uri,
  'album=s'  => \my $album,
  'artist=s' => \my $artist,
  'q=s'      => \my $q,
);

my $spotify = FeedMe::Metadata::Spotify->new;

my $result;

if ($id) {
  $result = $spotify->get_album( $id );
} elsif ($uri) {
  $result = $spotify->get_album( $uri );
} elsif ($artist and $album) {
  $result = $spotify->get_album( $artist, $album );
} elsif ($q) {
  $result = $spotify->_fetch('search', $q, 'album');
}else {
  say "expected --id or --uri or -q or (--arist and --album)"
}

warn Dumper $result;


say "done";

exit 0;