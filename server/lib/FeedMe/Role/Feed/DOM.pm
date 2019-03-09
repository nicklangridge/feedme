package FeedMe::Role::Feed::DOM;
use Moo::Role;
use Method::Signatures;
use Text::Trim;
use Mojo::DOM;
use Parallel::ForkManager;
use Data::Dumper;

with 'FeedMe::Role::Feed';

requires qw(
  extract_entry_urls
  parse_entry
);

method parallel_parsers { 0 }

method parse_feed ($url) {
  my $html = $self->_get($url) || die "Failed to fetch page [$url]: $!\n";
  
  if (0 && $ENV{FEEDME_FEEDCACHE_DIR}) {
    my $key    = ref $self;  
    my $cached = $self->_cache->get($key);
    
    if ($cached and $cached eq $html) {      
      warn "Cache hit for $key; skipping as feed has not changed\n";
      return ();
    } else {
      $self->_cache->set($key, $html, $self->cache_lifetime);
    }
  }
  
  my $dom = Mojo::DOM->new($html) || die "Failed to parse html: $!\n";  
  my @entry_urls = $self->extract_entry_urls($dom);
  
  my @reviews;
  
  if ($self->parallel_parsers) {
    # parallel
    my $pm = Parallel::ForkManager->new($self->parallel_parsers, $ENV{FEEDME_PFM_TMPDIR} || undef);
    
    $pm->run_on_finish (sub {
      my $data = pop @_;
      push @reviews, @$data;
    });
    
    foreach my $entry_url (@entry_urls) {
      $pm->start and next; # fork
      my @r = $self->parse_entry($entry_url);
      $pm->finish(0, \@r);
    }
    
    $pm->wait_all_children;
    
  } else { 
    # sequential
    foreach my $entry_url (@entry_urls) {
      push @reviews, $self->parse_entry($entry_url);
    }
  }

  return @reviews;
}

1;
