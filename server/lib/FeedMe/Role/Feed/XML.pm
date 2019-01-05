package FeedMe::Role::Feed::XML;
use Moo::Role;
use Method::Signatures;
use Text::Trim;
use XML::Feed;
use Parallel::ForkManager;

with 'FeedMe::Role::Feed';

method parallel_parsers { 0 }

method _preprocess_response ($response) {
  # strip common date stamps to allow cache comparison
  $response =~ s/<lastBuildDate>[^<>]+<\/lastBuildDate>//m;
  $response =~ s/<pubDate>[^<>]+<\/pubDate>//m;
  $response =~ s/<dc:date>[^<>]+<\/dc:date>//m;
  return $response;
}

method parse_feed ($url) {
  my $response = $self->_get($url)            || die "Failed to fetch feed [$url]: $!\n";
  
  $response = $self->_preprocess_response($response);
  
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
    
    $pm->wait_all_children;
  
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
