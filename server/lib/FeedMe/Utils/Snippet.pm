package FeedMe::Utils::Snippet;
use strict;
use warnings;
use Encode;
use HTML::Strip;

use parent qw(Exporter);
our @EXPORT_OK = qw( snippet );

sub snippet {
  my ($text, $len) = @_;
  $text = strip_html($text);
  $text =~ s/\s+/ /gm;

  if ($len and length($text) > $len) {
    $text = substr($text, 0, $len);

    (my $marked = $text) =~ s/([^A-Z])\.\s+/$1~#!#~/gm;
    my @sentences = split /~#!#~/, $marked;

    if (@sentences > 1) {
      # drop broken sentence
      pop @sentences; 
      $text = join('. ', @sentences) . '.';
    } else {
      # take it back to last whole word
      $text =~ s/\W+[\w]*$//; 
      $text .= "...";
    }
  }

  return $text;
}

sub strip_html {
  my ($html) = @_;
  my $hs = HTML::Strip->new();
  my $octets = encode_utf8($html);
  utf8::downgrade($octets);
  my $stripped = $hs->parse($octets);
  $hs->eof;
  $stripped = eval{ decode_utf8($stripped) } || $stripped;
  $stripped =~ s/\s+([,"'\.\?])/$1/gm;
  return $stripped;
}
