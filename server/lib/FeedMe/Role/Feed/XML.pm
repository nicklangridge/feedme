package FeedMe::Role::Feed::XML;
use Moo::Role;
use Method::Signatures;
use LWP::UserAgent;
use Text::Trim;
use XML::Feed;
use CHI;
use File::Path qw(make_path);
use Parallel::ForkManager;

with 'FeedMe::Role::Feed';

has '_ua' => (
  is       => 'rw',
  default  => sub {
    my $ua = LWP::UserAgent->new;
    $ua->agent( __PACKAGE__ );
    $ua->env_proxy;
    return $ua;
  }
);

has '_cache' => (
  is      => 'rw',
  default => sub {
    my $root = $ENV{FEEDME_FEEDCACHE_DIR} || '/tmp/feedme_feedcache';
    make_path($root) unless -d $root;
    return CHI->new( driver => 'File', root_dir => $root);
  }
);

method cache_lifetime { '12 hours' }

method parallel_parsers { 0 }

method _get ($url) {
  my $response = $self->_ua->get($url);
  return $response->is_success ? $response->decoded_content : undef;
}

method parse_feed ($url) {
  my $response = $self->_get($url)            || die "Failed to fetch feed [$url]: $!\n";

  if ($ENV{FEEDME_FEEDCACHE_DIR}) {
    my $key    = ref $self;  
    my $cached = $self->_cache->get($key);
    
    if ($cached and $cached eq $response) {      
      warn "Cache hit for $key; skipping as feed has not changed\n";
      return ();
    } else {
      $self->_cache->set($key, $response, $self->cache_lifetime);
    }
  }
  
  my $feed     = XML::Feed->parse(\$response) || die "Failed to parse feed: $!\n";
  my @reviews;
  
  if ($self->parallel_parsers) {
    # parallel
    my $pm = Parallel::ForkManager->new($self->parallel_parsers);
    
    $pm->run_on_finish (sub {
      my $data = pop @_;
      push @reviews, @$data;
    });
    
    foreach my $entry ($feed->entries) {
      $pm->start and next; # fork
      my @r = $self->parse_entry($entry);
      $pm->finish(0, \@r);
    }
  } else { 
    # sequential
    foreach my $entry ($feed->entries) {
      push @reviews, $self->parse_entry($entry);
    }
  }

  return @reviews;
}

method parse_entry ($entry) {
  return {
    title       => trim $entry->title,
    url         => trim $entry->link,
    description => undef, # by default we leave description to be added later
  }
}

1;
