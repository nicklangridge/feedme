package FeedMe::Metadata::Spotify;
use Moo;
use Method::Signatures;
use WebService::Spotify;

has 'api' => (
  is      => 'rw',
  default => sub {return WebService::Spotify->new}
);

method get_album_info ($artist, $album) {
  
  my $albums     = $self->_do('search', "$album artist:$artist", limit => 10, type => 'album');
  
  return {} unless $albums->{albums}->{total} > 0;
  
  my $album      = $albums->{albums}->{items}->[0];
  my $artist_uri = $album->{artists}->[0]->{uri};
  my $output     = {};
  
  if ($album and $artist_uri) {
    
    my $artist = $self->_do('artist', $artist_uri);
    
    $output = {
      artist_uri  => $artist_uri,
      artist_name => $artist->{name},
      genres      => $artist->{genres},
      regions     => $album->{available_markets},
      album_uri   => $album->{uri},
      album_name   => $album->{name},
    };
  }
  
  return $output;
}

method _do ($method, @args) {
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