use strict;
use warnings;
use feature 'say';
use lib 'lib';
use FeedMe::Model::API;
use Data::Dumper::Concise;

my $api = FeedMe::Model::API->new;

my @latest = $api->latest(
  region => 'US',
  limit => 10, 
  #genres => ['rock', 'pop'],
  feeds  => ['spotinews'], 
#  keywords => 'dj kicks'
);

say Dumper(\@latest);
