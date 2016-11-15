package FeedMe::DB;
use FeedMe::DB::Feeds;
use strict;
use warnings;
use feature 'state';

use parent qw(Exporter);
our @EXPORT_OK = qw( db );

sub db      { return __PACKAGE__ }; # singleton
sub feeds { return state $cache = FeedMe::DB::Feeds->new };

1;
