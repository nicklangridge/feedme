package FeedMe::Metadata::Spotify;
use Moo;
use Method::Signatures;
use WWW::Spotify;
use JSON;
use Data::Dumper;
use utf8::all;

my $retry_limit = 10;
my $retry_wait  = 2; # seconds
my $rate_limit_exceeded = 429;

has 'client_id'     => ( is => 'rw', required => 1 );
has 'client_secret' => ( is => 'rw', required => 1 );

has 'api' => (
  is      => 'rw',
  builder =>  '_build_api',
  lazy    => 1,
  default => sub {
    my $self = shift;
    return WWW::Spotify->new(
      oauth_client_id     => $self->client_id,
      oauth_client_secret => $self->client_secret,
    );
  }
);
  
method get_album_info (@args) {
  my $album;
  
  if (@args == 1) {
  
    my ($album_uri) = @args;
    my $album = $self->_fetch('album', $album_uri);
  
  } elsif (@args == 2) {
  
    my ($artist_name, $album_name) = @args;
    my $albums = $self->_fetch('search', "$album_name artist:$artist_name", 'album', { limit => 1 });
    if ($albums->{albums}->{total}) {
      $album = $albums->{albums}->{items}->[0];    
    }
    
  } else {
    die "unexpected number of args";
  }

  my $artist_id = $album->{artists}->[0]->{id};
  my $output     = {};
  
  if ($album and $artist_id) {
    
    my $artist = $self->_fetch('artist', $artist_id);
    
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
  # no exact match, maybe there is something close?
  foreach (@$images) {
    return $_->{url} if $_->{width} < $size + 20 and $_->{width} > $size - 20;
  }
  return undef;
}

method _fetch ($method, @args) {
  # perform an api request, wait and retry if rate limit hit
  my $result;
  
  foreach (1..$retry_limit) {   
    #$self->api->trace(1);
    $result = from_json( eval { $self->api->$method(@args) } );
  #warn Dumper($result);  
    
    if ($@ || $result->{error}) {
      warn $@ if $@;
      warn "Error: $result->{error}->{status} $result->{error}->{message}" if $result->{error};
      last unless $result->{error}->{status} == $rate_limit_exceeded; 
      warn "Waiting $retry_wait seconds before retrying...\n";
      sleep $retry_wait;
      next;
    }      
      
    last if ref $result eq 'HASH';
  }
  
  return $result;
}

1;