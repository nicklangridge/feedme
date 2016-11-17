package FeedMe::Model;
use FeedMe::Model::Feed;
use strict;
use warnings;
use feature 'state';

use parent qw(Exporter);
our @EXPORT_OK = qw( model );

sub model { return __PACKAGE__ }; # singleton
sub feed  { return state $cache = FeedMe::Model::Feed->new };

1;
