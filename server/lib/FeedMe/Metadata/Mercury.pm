package FeedMe::Metadata::Mercury;
use Moo;
use Method::Signatures;
use LWP::UserAgent;
use URI::QueryParam;
use JSON;
use utf8::all;

has 'base_uri' => ( is => 'rw', default => 'https://mercury.postlight.com/parser' );
has 'api_key'  => ( is => 'rw', required => 1 );
has 'trace'    => ( is => 'rw', default => 0 );

has 'user_agent' => (
  is => 'rw',
  default => sub { 
    my $ua = LWP::UserAgent->new;
    return $ua;
  }
);

method get ($document_url!) {
  my $uri = URI->new( $self->base_uri );
  $uri->query_param( url => $document_url );
  my $response = $self->user_agent->get( 
    $uri->as_string, 
    'Content-Type' => 'application/json',
    'x-api-key'    => $self->api_key,
  );
  
  $self->_log("GET", $uri->as_string);
  $self->_log("RESP", $response->content);

  return $response->content ? from_json($response->content) : undef;
}

method excerpt ($document_url!) {
  my $data = $self->get($document_url);
  return $data ? $data->{excerpt} : undef;
}

method _log (@strings) {
  print join(' ', @strings) . "\n" if $self->trace;
}

1;