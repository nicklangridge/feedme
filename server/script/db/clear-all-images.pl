#!/usr/bin/env perl

use strict;
use feature 'say';
use lib 'lib';
use FeedMe::MySQL qw(dbh);
 
say dbh->query("UPDATE album SET image=null");
say 'done';
