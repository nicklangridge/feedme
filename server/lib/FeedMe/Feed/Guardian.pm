package FeedMe::Feed::Guardian;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::XML';

sub name         { 'Guardian' };
sub url          { 'https://www.theguardian.com/music+tone/albumreview/rss' };
sub homepage_url { 'https://www.theguardian.com/music+tone/albumreview' };

method extract_artist_and_album ($title) {
  $title =~ s/\s+/ /g;
  $title =~ /(.+?)\s*\:\s+(.+)\s+review/;  
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

method parse_review ($r) {
  return {} unless $r->{title};
  
  my $aa = $self->extract_artist_and_album($r->{title} =~ s/\s+/ /gr);
  my $snippet = [split /review\s+(?:\x{2013}|\x{2014}|-)/, $r->{title}]->[-1];
  
  return {
    artist  => $aa->{artist},
    album   => $aa->{album},
    url     => $r->{url},
    snippet => trim($snippet),
    source  => $self->slug
  }
}

1;