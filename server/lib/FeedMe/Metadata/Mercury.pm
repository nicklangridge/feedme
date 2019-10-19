package FeedMe::Metadata::Mercury;
use Moo;
use Method::Signatures;
use LWP::UserAgent;
use URI::QueryParam;
use JSON;
use Encode;
use utf8::all;
use FeedMe::Config qw(config);

has 'base_uri' => ( is => 'rw', default => 'https://mercury.postlight.com/parser' );
has 'api_key'  => ( is => 'rw', default => config->{mercury_api_key} );
has 'command'  => ( is => 'rw', default => config->{mercury_command} );
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

  my $content;
  if ($response->content) {
    my $decoded = decode('utf-8', $response->content);
    $content = eval { from_json($decoded) } || undef;
    warn "Failed to parse Mercury response: $@\n(content = '" . $response->content . "')" if $@;
  }

  return $content;
}

method get_local ($document_url!) {
  my $command = $self->command . ' ' . $document_url;
  
  $self->_log($command);

  my $result = `$command`;
 
  $self->_log($result);

  my $content;
  if ($result) {
	  #my $decoded = decode('utf-8', $result);
    $content = eval { from_json($result) } || undef;
    warn "Failed to parse Mercury result: $@\n(content = '" . $result . "')" if $@;
  }

  return $content;
}


method excerpt ($document_url!) {
  my $data = $self->get_local($document_url);
  my $excerpt;
  if ($data) {
    $excerpt = $data->{excerpt};
    $excerpt =~ s/&hellip;/.../;
  }
  return $excerpt;
}

method _log (@strings) {
  print join(' ', @strings) . "\n" if $self->trace;
}

1;
