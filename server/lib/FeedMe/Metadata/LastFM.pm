package FeedMe::Metadata::LastFM;
use Moo;
use Method::Signatures;
use Net::LastFM;
use JSON;
use Data::Dumper;
use FeedMe::Config qw(config);
use utf8::all;
use feature 'say';

has 'api_key' => ( is => 'rw', default => config->{lastfm_api_key} );

has 'api' => (
  is      => 'rw',
  lazy    => 1,
  default => sub {
    my $self = shift;
    return Net::LastFM->new(api_key => $self->api_key, api_secret => '');
  }
);

sub get_artist_info () {
  my $self = shift;
  my $artist_name = shift;
  my $artist = $self->api->request(
    method => 'artist.getinfo', 
    artist => $artist_name,
    format => 'json',
  );
  
  return $artist;
};

1;
