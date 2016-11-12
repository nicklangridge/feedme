package FeedMe::Role::Feed::XML;
use Moo::Role;
use Method::Signatures;
use LWP::UserAgent;
use Text::Trim;
use XML::Feed;

with 'FeedMe::Role::Feed';

has '_ua' => (
  is       => 'rw',
  required => 0,
  default  => sub {
    my $ua = LWP::UserAgent->new;
    $ua->agent( __PACKAGE__ );
    $ua->env_proxy;
    return $ua;
  }
);

method _get ($url) {
  my $response = $self->_ua->get($url);
  return $response->is_success ? $response->decoded_content : undef;
}

method parse_feed ($url) {
  my $response = $self->_get($url)            || die "Failed to fetch feed [$url]: $!\n";
  my $feed     = XML::Feed->parse(\$response) || die "Failed to parse feed: $!\n";
  my @reviews;
  
  foreach my $entry ($feed->entries) {
    push @reviews, $self->parse_entry($entry);
  }

  return @reviews;
}

method parse_entry ($entry) {
  return {
    title   => trim $entry->title,
    url     => trim $entry->link,
  }
}

1;
