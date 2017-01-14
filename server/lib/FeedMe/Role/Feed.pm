package FeedMe::Role::Feed;
use Moo::Role;
use Method::Signatures;
use Text::Trim;

requires qw(
  url
  name
  homepage_url
  parse_feed
);

has 'slug' => (
  is => 'ro',
  default => sub { return lc [split /::/, ref $_[0]]->[-1] }
);

method fetch {
  my @reviews = $self->parse_feed($self->url);
  
  @reviews = grep {$self->want_review($_)}
             grep {$self->valid_review($_)}
             map  {$self->parse_review($_)} @reviews;
      
  return @reviews;
}

method parse_review ($r) {
  return {} unless $r->{title};
  
  my $aa = $self->extract_artist_and_album($r->{title} =~ s/\s+/ /gr);
  return {
    artist  => $aa->{artist},
    album   => $aa->{album},
    url     => $r->{url},
    snippet => $r->{description},
    source  => $self->slug
  }
}

method extract_artist_and_album ($title) {
  $title =~ /(.+?)\s+(?:\x{2013}|\x{2014}|-|–)\s+(.+)/;
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

method want_review ($r) {
  return $r->{artist} !~ /^various artists/i;
}

method valid_review ($r) {
  for (qw(artist album url)) {
    return 0 if !length($r->{$_});
  }
  return 1;
}

1;