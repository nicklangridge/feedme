package FeedMe::Config;
use strict;
use warnings;
use 5.10.1;
use FindBin qw($Bin);

use parent qw(Exporter);
our @EXPORT_OK = qw( config );

sub config {
  state $config = do ($ENV{FEEDME_CONFIG_FILE} || ("$Bin/../config/" . ($ENV{FEEDME_ENV} || 'dev') . '.conf'));
  return $config;
}

1;