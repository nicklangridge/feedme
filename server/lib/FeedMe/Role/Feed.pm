package FeedMe::Role::Feed;
use Moo::Role;
use Method::Signatures;
use Text::Trim;
use LWP::UserAgent;
use CHI;
use File::Path qw(make_path);

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

has '_ua' => (
  is       => 'rw',
  default  => sub {
    my $ua = LWP::UserAgent->new;
    $ua->agent( __PACKAGE__ );
    $ua->env_proxy;
    return $ua;
  }
);

has '_cache' => (
  is      => 'rw',
  default => sub {
    my $root = $ENV{FEEDME_FEEDCACHE_DIR} || '/tmp/feedme_feedcache';
    make_path($root) unless -d $root;
    return CHI->new( driver => 'File', root_dir => $root);
  }
);

method cache_lifetime { '12 hours' }

method _get ($url) {
  my $response = $self->_ua->get($url);
  return $response->is_success ? $response->decoded_content : undef;
}

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