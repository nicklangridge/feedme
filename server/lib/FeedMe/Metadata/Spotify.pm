package FeedMe::Metadata::Spotify;
use Moo;
use Method::Signatures;
use WebService::Spotify;

my $retry_limit = 10;
my $retry_wait  = 10; # seconds

has 'api' => (
  is      => 'rw',
  default => sub {return WebService::Spotify->new}
);

method get_album_info ($artist_name, $album_name) {
  
  my $albums     = $self->_fetch('search', "$album_name artist:$artist_name", limit => 10, type => 'album');
  
  return {} unless $albums->{albums}->{total};
  
  my $album      = $albums->{albums}->{items}->[0];
  my $artist_uri = $album->{artists}->[0]->{uri};
  my $output     = {};
  
  if ($album and $artist_uri) {
    
    my $artist = $self->_fetch('artist', $artist_uri);
    
    if ($artist) {
      $output = {
        uri         => $album->{uri},
        name        => $album->{name},
        image       => $self->_get_image($album->{images}, 300),
        regions     => $album->{available_markets},  
        artist_uri  => $artist->{uri},
        artist_name => $artist->{name},
        genres      => $artist->{genres},
      };
    }
  }
  
  return $output;
}

method _get_image ($images, $size) {
  foreach (@$images) {
    return $_->{url} if $_->{width} == $size;
  }
  return undef;
}

method _fetch ($method, @args) {
  # perform an api request, wait and retry if rate limit hit
  my $result;
  
  foreach (1..$retry_limit) {   
    #$self->api->trace(1);
    $result = eval { $self->api->$method(@args) };
    
    if ($@ || $result->{error}) {
      warn $@ if $@;
      warn "Error: $result->{error}->{status} $result->{error}->{message}" if $result->{error};
      warn "Waiting $retry_wait seconds before retrying...\n";
      sleep $retry_wait;
      next;
    }      
      
    last if ref $result eq 'HASH';
  }
  
  return $result;
}

1;