package FeedMe::Metadata::LastFM;
use Moo;
use Method::Signatures;
use Net::LastFM;

has 'api_key' => (
  is       => 'rw',
  required => 1,
);

has 'api_secret' => (
  is       => 'rw',
  required => 1,
);

has 'api' => (
  is       => 'rw',
  lazy     => 1,
  default  => sub { 
    my $lastfm = Net::LastFM->new(
      api_key    => $_[0]->api_key, 
      api_secret => $_[0]->api_secret
    );
    $lastfm->ua->agent( __PACKAGE__ ); # default useragent appears banned?
    return $lastfm;
  }
);

method artist_info ($artist) {
  my $output = {};
  my $data;
  
  eval {
    my $response = $self->api->request(method => 'artist.getInfo', artist => $artist);
    $data        = $response->{artist};
  };
  
  #warn "LastFM artist_info error: $@" if $@;

  if ($data) {
    if (my $bio = $data->{bio}) {
      $output = {
        bio        => $bio->{summary} ,
        bio_source => 'last.fm',
        bio_url    => $data->{url} || $bio->{links}->{link}->{href}
      }
    }

    my $tags = ['uncategorised'];

    if (ref $data->{tags} eq 'HASH') {
      $tags = $data->{tags}->{tag};
      $tags = [$tags] if ref($tags) ne 'ARRAY';
      $tags = [map {$_->{name}} @$tags];
    }

    $output->{tags} = $tags;
  }

  return $output;  
}

1;