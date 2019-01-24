use strict;
use feature 'say';
use lib 'lib';
use Data::Dumper;
use Module::Loader;
use Getopt::Long;
use FeedMe::Model 'model';

GetOptions (
  'public'  => \(my $public = 0),
);

my @modules = @ARGV;
my $loader = Module::Loader->new;

if (@modules) {
  @modules = map {"FeedMe::Feed::$_"} @modules;
} else {
  @modules = sort $loader->find_modules('FeedMe::Feed');
}

my @added;

foreach my $module (@modules) {
  $loader->load($module);
  
  my $feed = $module->new;

  my $data = model->feed->fetch_or_create({
    slug         => $feed->slug,
    name         => $feed->name,
    homepage_url => $feed->homepage_url,
    module       => $module,
    public       => $public,
  });
  
  if ($data->{_created}) {
    say $module;
    push @added, $module;
  }
}

say "Added " . scalar(@added) . " feeds";