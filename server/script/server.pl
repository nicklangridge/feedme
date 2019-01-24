#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw($Bin);
BEGIN { unshift @INC, "$Bin/../lib" }
use Mojolicious::Commands;

# Start command line interface for application
Mojolicious::Commands->start_app('FeedMe::Server');
