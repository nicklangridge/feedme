use Test::Most;
use Module::Loader;

my $loader  = Module::Loader->new;
my @modules = sort $loader->find_modules('FeedMe::Feed');

foreach my $module (@modules) {
  use_ok $module;
  
  my $feed = new_ok $module;
  my @reviews = $feed->fetch; 
  ok @reviews > 0, 'got some reviews (' . scalar(@reviews) . ')';
  
  my $valid = 1;
  foreach (@reviews) {
    $valid = 0 unless 
      length($_->{artist}) &&
      length($_->{album})  &&
      length($_->{url});
  }
  ok $valid, 'all reviews have expected fields';
}