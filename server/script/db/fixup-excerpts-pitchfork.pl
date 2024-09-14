#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use lib 'lib';
use utf8::all;

use FeedMe::Model 'model';
use FeedMe::Config qw(config);
use FeedMe::Feed::Pitchfork;

my @reviews = model->review->fetch_where({ -and => { snippet => { -like => 'Read % album.' } , feed_id => 4 }});

my $count = @reviews;

my $feed = FeedMe::Feed::Pitchfork->new;

foreach my $review (@reviews) {
  say $count--;
  say "O: $review->{url}: $review->{snippet}";	
  my $new = $feed->parse_entry($review->{url});
  $review->{snippet} = $new->{description};
  say "N: $review->{url}: $review->{snippet}";
  #say $review->{snippet};
  say '';
  model->review->save($review) if $review->{snippet};
  sleep 1;
}
