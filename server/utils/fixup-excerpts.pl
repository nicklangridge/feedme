use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use FeedMe::Model 'model';
use FeedMe::Metadata::Mercury;
use FeedMe::Config qw(config);

my $mercury = FeedMe::Metadata::Mercury->new(api_key => config->{mercury_api_key});
my @reviews = model->review->fetch_where({ snippet => undef });

foreach my $review (@reviews) {
  $review->{snippet} = $mercury->excerpt($review->{url});
  say "$review->{snippet}";
  model->review->save($review) if $review->{snippet};
}