package FeedMe::Metadata::MusicStory;
use Moo;
use Method::Signatures;
use utf8::all;
use feature 'say';
use FeedMe::Config qw(config);


has 'api_bin'    => ( is => 'rw', default => config->{musicstory_api_bin} );
has 'api_key'    => ( is => 'rw', default => config->{musicstory_api_key} );
has 'api_secret' => ( is => 'rw', default => config->{musicstory_api_secret} );
has 'trace'      => ( is => 'rw', default => 0 );

method get_artist_genres ($artist_name!) {
  
  my $cmd = sprintf '%s %s %s "%s"', $self->api_bin, $self->api_key, $self->api_secret, $artist_name;  
  $self->_log($cmd);
  my $output = `$cmd`;
  
  my @genres = split /\n/, $output;
  $self->_log(join ', ', @genres);
  
  return @genres;
}

method _log (@strings) {
  print join(' ', @strings) . "\n" if $self->trace;
}

1;