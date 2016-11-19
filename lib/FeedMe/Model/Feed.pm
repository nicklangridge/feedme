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
  return dbh->insert('feed', $feed) || die dbh->error;
}

method fetch_or_create($args!) {
  die 'feed slug is required' if !$args->{slug}; 
  
  my $feed = $self->fetch_by_slug($args->{slug});

  if (!$feed) {
    $self->insert($args);
    $feed = $self->fetch_by_slug($args->{slug});
    $feed->{_created} = 1;
  }

  return $feed;
}

method fetch_reviews($feed!) {
  die 'feed has no feed_id'        if !$feed->{feed_id};
  die 'feed has no module defined' if !$feed->{module}; 
  Module::Loader->new->load($feed->{module});
  my @reviews;
  eval { @reviews = $feed->{module}->new->fetch }; 
  warn "Error fetching $feed->{module}: $@" if $@;
  $_->{feed_id} = $feed->{feed_id} for @reviews;
  return @reviews;
}

1;