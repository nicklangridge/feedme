package FeedMe::Model::Feed;
use Moo;
use Method::Signatures;
use Module::Loader;
use FeedMe::MySQL qw(dbh);

method fetch_all {
  return dbh->query('SELECT * FROM feed')->hashes;
}

method fetch_active {
  return dbh->query('SELECT * FROM feed WHERE active = 1')->hashes;
}

method fetch_public {
  return dbh->query('SELECT * FROM feed WHERE public = 1')->hashes;
}

method fetch_by_slug ($slug!) {
  my ($row) = dbh->query('SELECT * FROM feed WHERE slug = ?', $slug)->hashes;
  return $row;
}

method insert ($feed!) {
  dbh->insert('feed', $feed) || die dbh->error;
}

method fetch_or_create($feed!) {
  # using slug as unique key
  die 'feed slug is required' if !$feed->{slug}; 
  
  my ($result) = dbh->query("SELECT * FROM feed WHERE slug = ?", $feed->{slug})->hashes;

  if (!$result) {
    $self->insert($feed);
    $result = $self->fetch_by_slug($feed->{slug});
    $result->{_created} = 1;
  }

  return $result;
}

method fetch_reviews($feed!) {
  die 'feed has no module defined' if !$feed->{module}; 
  
  Module::Loader->new->load($feed->{module});
  
  my @reviews;
  
  eval { @reviews = $feed->{module}->new->fetch }; 
  
  warn "Error fetching $feed->{module}: $@" if $@;
  
  return @reviews;
}

1;