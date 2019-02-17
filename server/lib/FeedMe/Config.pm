package FeedMe::Config;
use strict;
use warnings;
use 5.10.1;
use FindBin qw($Bin);

use parent qw(Exporter);

our @EXPORT_OK = qw( config );

sub config {
  state $config;
  
  unless ($config) {
    if ($ENV{FEEDME_CONFIG_FILE}) {
      $config = do $ENV{FEEDME_CONFIG_FILE}
    } else {
      my $dir = -d "$Bin/config"       ? "$Bin/config" :
                -d "$Bin/../config"    ? "$Bin/../config" :
                -d "$Bin/../../config" ? "$Bin/../../config" : die("Can't auto-locate config dir");
      $config = do ("$dir/" . ($ENV{FEEDME_ENV} || 'dev') . '.conf');
    }
  }
  
  return $config;
}

1;