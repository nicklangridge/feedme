#!/usr/bin/env perl

use strict;
use feature 'say';
use lib 'lib';
use Data::Dumper;
use Module::Loader;
use Getopt::Long;
use FeedMe::Metadata::Mercury;
use FeedMe::Config qw(config);

GetOptions (
  'p|print'   => \my $print,
  'v|verbose' => \my $verbose, 
  's|snippet' => \my $snippet,
);

my $mercury;
if ($snippet and config->{mercury_api_key}) {
  $mercury = FeedMe::Metadata::Mercury->new(api_key => config->{mercury_api_key});
}

my @modules = @ARGV;
my $loader = Module::Loader->new;

if (@modules) {
  @modules = map {"FeedMe::Feed::$_"} @modules;
} else {
  @modules = sort $loader->find_modules('FeedMe::Feed');
}

foreach my $module (@modules) {
  say $module;
  $loader->load($module);
  
  my $feed    = $module->new;
  my @reviews = $feed->fetch; 
  
  say "got " . scalar(@reviews);
  
  if ($mercury) {
    $_->{snippet} = $mercury->excerpt($_->{url}) for @reviews;
  }
  
  if ($verbose) {
    say Dumper \@reviews;
  } elsif ($print) {
    say "$_->{artist} - $_->{album} [$_->{url}]" for @reviews;
  }
}