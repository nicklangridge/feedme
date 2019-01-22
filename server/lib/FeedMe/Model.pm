package FeedMe::Model;
use strict;
use warnings;
use feature 'state';
use utf8::all;

use FeedMe::Model::Feed;
use FeedMe::Model::Album;
use FeedMe::Model::Artist;
use FeedMe::Model::Review;
use FeedMe::Model::MusicStory;
use FeedMe::Model::Genres;

use parent qw(Exporter);
our @EXPORT_OK = qw( model );

sub model      { return __PACKAGE__ }; # singleton
sub feed       { return state $cache = FeedMe::Model::Feed->new };
sub album      { return state $cache = FeedMe::Model::Album->new };
sub artist     { return state $cache = FeedMe::Model::Artist->new };
sub review     { return state $cache = FeedMe::Model::Review->new };
sub musicstory { return state $cache = FeedMe::Model::MusicStory->new };
sub genres     { return state $cache = FeedMe::Model::Genres->new };

1;
