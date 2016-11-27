package FeedMe::Utils::Slug;
use Text::Unaccent::PurePerl;
use strict;
use warnings;

use parent qw(Exporter);
our @EXPORT_OK = qw( slug );

sub slug {
  my $name = shift;
  $name = unac_string($name);
  $name =~ s/&/and/g;
  $name =~ s/['"]//g;
  $name =~ s/[^a-z0-9]/-/ig;
  $name =~ s/-+/-/g;
  $name =~ s/^-//;
  $name =~ s/-$//;
  return lc($name);
}