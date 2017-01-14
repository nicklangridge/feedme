package FeedMe::Feed::AfroMonk;
use Moo;
use Method::Signatures;
use Text::Trim;
use HTML::Strip;

my $html_strip = HTML::Strip->new();
  
with 'FeedMe::Role::Feed::XML';

sub name         { 'AfroMonk' };
sub url          { 'https://afromonk.com/feed/' };
sub homepage_url { 'https://afromonk.com' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
  $title =~ /(.+?)\s+(?:\x{7C}|\|)(.+)/;
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

method parse_entry ($entry) {
  return {
    title       => trim $entry->title,
    url         => trim $entry->link,
    description => trim $html_strip->parse($entry->content->body), 
  }
}

1;