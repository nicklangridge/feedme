package FeedMe::Metadata::Spotify;
use Moo;
use Method::Signatures;
use WWW::Spotify;
use JSON;
use Data::Dumper;
use Encode qw(decode);
use FeedMe::Config qw(config);
use utf8::all;
use feature 'say';

my $retry_limit = 10;
my $retry_wait  = 10; # seconds
my $rate_limit_exceeded = 429;
my @primary_regions = qw(GB US);

has 'client_id'     => ( is => 'rw', default => config->{spotify_client_id} );
has 'client_secret' => ( is => 'rw', default => config->{spotify_client_secret} );

has 'api' => (
  is      => 'rw',
  builder =>  '_build_api',
  lazy    => 1,
  default => sub {
    my $self = shift;
    return WWW::Spotify->new(
      oauth_client_id     => $self->client_id,
      oauth_client_secret => $self->client_secret,
      debug => 0,
    );
  }
);
  
method get_album_info ($artist_name!, $album_name!) {
  
  my ($album, $regions) = $self->get_album_and_availability( $artist_name, $album_name, \@primary_regions );
  my $artist_id = $album->{artists}->[0]->{id};
  my $output    = {};
  
  if  ($album and $artist_id) {
    my $artist = $self->_fetch('artist', $artist_id);
    
    if ($artist) {    
      $output = {
        uri         => $album->{uri},
        name        => $album->{name},
        image       => $self->_get_image($album->{images}, 640) || $self->_get_image($album->{images}, 300),
        regions     => $regions,  
        artist_uri  => $artist->{uri},
        artist_name => $artist->{name},
        genres      => $artist->{genres},
        album_type  => $album->{album_type},
      };
    }
  }
  
  return $output;
}

method get_album_and_availability ($artist_name!, $album_name!, $regions!) {
  
  my @albums = $self->get_albums_for_regions($artist_name, $album_name, $regions);
  return unless @albums;

  my $ids         = join(',', map { $_->{id} } @albums);
  my $results     = $self->_fetch('albums', $ids);
  my @full_albums = grep {$_} @{ $results->{albums} };
  
  my %regions;
  foreach my $full_album (@full_albums) {
    #say $full_album->{id} . ' -- ' . join(', ', @{ $full_album->{available_markets}});
    $regions{$_ } = 1 foreach @{ $full_album->{available_markets} };
  }
  
  return $albums[0], [sort keys %regions];
}

method get_albums_for_regions ($artist_name!, $album_name!, $regions!) {
  
  my %albums;
  
  foreach my $region (@$regions) {
    my $album = $self->get_album($artist_name, $album_name, $region);
    if ($album) {
      $albums{$album->{id}} = $album;     
    }
  }
  
  return values %albums;
}

method get_album ($artist_name!, $album_name!, $region!) {
  
  my $album;
  
  my $results = $self->_fetch('search', "$album_name artist:$artist_name", 'album', { limit => 1, market => $region });
  if ($results->{albums}->{total}) {
    $album = $results->{albums}->{items}->[0];    
  }
  
  return $album;
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
    my $response = eval { $self->api->$method(@args) };
    
    $result = from_json( decode('UTF-8', $response) );
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

method _get_id ($type, $id) {
  my @fields = split /:/, $id;
  if (@fields == 3) {
    warn "expected id of type $type but found type $fields[2] id" if $type ne $fields[1];
    return $fields[2];
  }
 
  @fields = split /\//, $id;
  if (@fields >= 3) {
    warn "expected id of type $type but found type $fields[-2] id" if $type ne $fields[-2];
    return $fields[-1];
  }
 
  return $id;
}

1;
