use strict;
use feature 'say';
use lib 'lib';
use Data::Dumper;
use Getopt::Long;
use Parallel::ForkManager;
use FeedMe::Model 'model';

GetOptions (
  'p|print'     => \my $print,
  'v|verbose'   => \my $verbose, 
  'w|workers=n' => \(my $workers = 5),
);

my @slugs = @ARGV;
my @feeds = model->feed->fetch_active;

if (@slugs) {
  # keep only the feeds specified by slug
  @feeds = grep {my $feed = $_; grep {$feed->{slug} eq $_} @slugs} @feeds;
  
  if (!@feeds) {
    say 'No active feeds match your input';
    exit;
  }
}

my $pm = Parallel::ForkManager->new($workers);
my @reviews;

$pm->run_on_finish (sub {
  my $data = pop @_;
  push @reviews, @$data;
});

foreach my $feed (@feeds) {
  $pm->start and next; # fork
  my @r = model->feed->fetch_reviews($feed);
  say "$feed->{slug}:" . scalar(@r);  
  $pm->finish(0, \@r);
}

$pm->wait_all_children;

#say Dumper(\@reviews);

say "$_->{artist} - $_->{album} [$_->{url}] ($_->{source})" for @reviews;