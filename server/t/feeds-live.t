use Test::Most;
use Module::Loader;

my $loader  = Module::Loader->new;
my @modules = sort $loader->find_modules('FeedMe::Feed');

foreach my $module (@modules) {
  use_ok $module;
  
  my $feed = new_ok $module;
  my @reviews = $feed->fetch; 
  ok @reviews > 0, 'got some reviews (' . scalar(@reviews) . ')';
  
  my @invalid = grep {!($_->{artist} && $_->{album} && $_->{url})} @reviews;
  ok @invalid == 0, 'all reviews have expected fields';
}

done_testing();