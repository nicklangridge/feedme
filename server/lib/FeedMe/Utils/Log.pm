package FeedMe::Utils::Log;
use strict;
use warnings;
use Term::ANSIColor;
use feature 'say';

use parent qw(Exporter);
our @EXPORT_OK = qw( yay info warning error );

sub yay { _print('green', @_) }
sub info { _print(undef, @_) }
sub warning { _print('yellow', @_) }
sub error { _print('red', @_) }

sub _print {
  my ($color, $message, $verbose) = @_;
  
  if ((!defined $verbose) or (defined $verbose and $verbose)) {
    if ($color) {
      say color($color), $message, color("reset");
    } else {
      say $message;
    }
  }
}