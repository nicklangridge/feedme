use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use Method::Signatures;
use Data::Dumper;
use Getopt::Long;
use FeedMe::Model 'model';
use FeedMe::MySQL 'dbh';


my %db  = map {$_ => 1} dbh->query('SELECT distinct( slug ) FROM album_genre')->flat;

my %mod;
foreach my $root (@{ model->genres->root_genres }) {
  foreach my $sub (@{ model->genres->sub_genres($root) }) {
    $mod{$sub} = 1;
  }
}

foreach (sort keys %db) {
  say "$_ not in model" if !$mod{$_};
}

foreach (sort keys %mod) {
  say "$_ not in db" if !$db{$_};
}