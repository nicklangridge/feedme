use strict;
use warnings;
use feature 'say';
use lib 'lib';
use FeedMe::Model::API;
use Getopt::Long;
use JSON;

GetOptions(
  'region=s'   => \my $region,
  'offset=s'   => \my $offset,
  'limit=s'    => \my $limit,
  'keywords=s' => \my $keywords,
  'genres=s'   => \my $genres,
  'feeds=s'    => \my $feeds,
);

my $api = FeedMe::Model::API->new;

my @args;
push(@args, region   => $region)              if $region;
push(@args, offset   => $offset)              if $offset;
push(@args, limit    => $limit)               if $limit;
push(@args, keywords => $keywords)            if $keywords;
push(@args, genres   => [split /,/, $genres]) if $genres;
push(@args, feeds    => [split /,/, $feeds])  if $feeds;

my @latest = $api->latest(@args);

say to_json(\@latest, {pretty => 1});
