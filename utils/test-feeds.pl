use strict;
use feature 'say';
use lib 'lib';
use Data::Dumper;
use Module::Loader;
use Getopt::Long;

GetOptions (
  'p|print'   => \my $print,
  'v|verbose' => \my $verbose, 
  'module=s'  => \my $module_list,
);

my $loader = Module::Loader->new;
my @modules; 

if ($module_list) {
  @modules = map {"FeedMe::Feed::$_"} split(/,/, $module_list);
} else {
  @modules = sort $loader->find_modules('FeedMe::Feed');
}

foreach my $module (@modules) {
  say $module;
  $loader->load($module);
  
  my $feed    = $module->new;
  my @reviews = $feed->fetch; 
  
  say "got " . scalar(@reviews);
  
  if ($verbose) {
    say Dumper \@reviews;
  } elsif ($print) {
    say "$_->{artist} - $_->{album} [$_->{url}]" for @reviews;
  }
}