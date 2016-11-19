package FeedMe::Model::Artist;
use Moo;
use Method::Signatures;
use FeedMe::MySQL qw(dbh);

method insert ($artist!) {
  return dbh->insert('artist', $artist) || die dbh->error;
}

method fetch_by_uri ($uri!) {
  my ($row) = dbh->query('SELECT * FROM artist WHERE uri = ?', $uri)->hashes;
  return $row;
}

method fetch_or_create ($args!) {
  die 'artist uri is required' if !$args->{uri}; 
  
  my $artist = $self->fetch_by_uri($slug);
  
  if (!$artist) {
    $self->insert({ 
      slug => slug($args->{name}),
      name => $args->{name},
      uri  => $args->{uri}
    });
    $artist = $self->fetch_by_uri($slug);
    $artist->{_created} = 1;
  }

  return $artist;
}

1;