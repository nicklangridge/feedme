package FeedMe::Role::Feed::XML;
use Moo::Role;
use Method::Signatures;
use LWP::UserAgent;
use Text::Trim;
use XML::Feed;

with 'FeedMe::Role::Feed';

requires qw(url);

has '_ua' => (
  is       => 'rw',
  isa      => 'LWP::UserAgent',
  required => 0,
  default  => sub {
    my $ua = LWP::UserAgent->new;
    $ua->agent( __PACKAGE__ );
    $ua->env_proxy;
    return $ua;
  }
);

method _get ($url) {
  my $response = $self->ua->get($url);
  return $response->is_success ? $response->decoded_content : undef;
}

method parse_feed ($url) {
  my $response = $self->_get($url)            || die "Failed to fetch feed [$url]: $!\n";
  my $feed     = XML::Feed->parse(\$response) || die "Failed to parse feed: $!\n";
  my @reviews;
  
  foreach my $entry ($feed->entries) {
    push @reviews, {
      title   => trim $entry->title,
      url     => trim $entry->link,
      #content => trim $entry->content->body,
    }
  }

  return @reviews;
}

