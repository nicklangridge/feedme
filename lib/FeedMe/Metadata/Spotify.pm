package FeedMe::Metadata::Spotify;
use Moo;
use Method::Signatures;
use WebService::Spotify;

has 'api' => (
  is      => 'rw',
  default => sub {return WebService::Spotify->new}
);

method get_album_info ($artist_name, $album_name) {
  
  my $albums     = $self->_fetch('search', "$album_name artist:$artist_name", limit => 10, type => 'album');
  
  return {} unless $albums->{albums}->{total} > 0;
  
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
  my $max_retry = 10;
  my $result;
  
  foreach (1..$max_retry) {   
    
    $result = eval { $self->api->$method(@args) };
    
    if ($@) {
      warn $@;
      return undef if $@ =~ /400 Bad Request/;
      sleep 1; # try again in a sec
    }      
      
    last if ref $result eq 'HASH';
  }
  
  return $result;
}

1;