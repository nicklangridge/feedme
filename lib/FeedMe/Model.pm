package FeedMe::Model;
use strict;
use warnings;
use feature 'state';

use FeedMe::Model::Feed;
use FeedMe::Model::Album;
use FeedMe::Model::Artist;
use FeedMe::Model::Review;

use parent qw(Exporter);
our @EXPORT_OK = qw( model );

sub model  { return __PACKAGE__ }; # singleton
sub feed   { return state $cache = FeedMe::Model::Feed->new };
sub album  { return state $cache = FeedMe::Model::Album->new };
sub artist { return state $cache = FeedMe::Model::Artist->new };
sub review { return state $cache = FeedMe::Model::Review->new };

1;
