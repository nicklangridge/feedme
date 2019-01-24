#!/usr/bin/env perl

use strict;
use warnings;
use Daemon::Control;
use FindBin qw($Bin);
use File::Basename qw(dirname);
use File::Path qw(make_path);
use Fcntl ':mode';

my $root_dir         = "$Bin/../";
my $psgi_file        = "$root_dir/script/server.pl";
my $status_file      = "$root_dir/feedme.status";
my $pid_file         = "$root_dir/feedme.pid";
my $log_root         = "$root_dir/logs";
my $init_config      = '~/.bashrc';
my $port             = $ENV{FEEDME_API_PORT}         || 8081;
my $workers          = $ENV{FEEDME_API_WORKERS}      || 5;
my $backlog          = $ENV{FEEDME_API_BACKLOG}      || 1024;
my $max_requests     = $ENV{FEEDME_API_MAX_REQUESTS} || 10000;
my $restart_interval = 1;

if ($ARGV[0] =~ /^(start|restart|foreground)$/) {
  ensure_dir_exists($log_root, 0755, 'log root');
}

Daemon::Control->new(
  {
    name         => "feedme API",
    lsb_start    => '$syslog $remote_fs',
    lsb_stop     => '$syslog',
    lsb_sdesc    => 'feedme API server control',
    lsb_desc     => 'feedme API server control',
    stop_signals => [ qw(QUIT TERM TERM INT KILL) ],
    init_config  => $init_config,
    pid_file     => $pid_file,
    program      => 'starman',
    program_args => [ 
      '--error-log',   "$log_root/error.log",
      '--access-log',  "$log_root/access.log",
      '--backlog',     $backlog,
      '--listen',      ":$port", 
      '--workers',     $workers, 
      '--max-requests',$max_requests,
      '--status-file', $status_file,
      '--interval',    $restart_interval,
      $psgi_file 
    ],
  }
)->run;

sub ensure_dir_exists {
  my ($dir, $target_mode, $name) = @_;

  if (! -d $dir) {
    warn "Creating $name directory '$dir'\n";
    make_path($dir, {chmod => $target_mode});
  }

  my $mode = S_IMODE( (stat($dir))[2] );
  if ($mode ne $target_mode) {
    warn "Setting permissions of $name directory '$dir'\n";
    chmod($target_mode, $dir) || die "Failed to set permissions: $!";
  }

  return;
}