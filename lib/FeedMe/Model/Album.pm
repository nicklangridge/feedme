package FeedMe::Model::Album;
use Moo;
use Method::Signatures;
use FeedMe::MySQL qw(dbh);
use FeedMe::Utils::Slug qw(slug);

method insert ($album!) {
  return dbh->insert('album', $album) || die dbh->error;
}

method fetch_by_uri_and_artist_id ($uri!, $artist_id!) {
  my ($row) = dbh->query('SELECT * FROM album WHERE uri = ? AND artist_id = ?', $uri, $artist_id)->hashes;
  return $row;
}

method fetch_or_create ($args!) {
  die 'album uri is required' if !$args->{uri}; 
  die 'artist_id is required'  if !$args->{artist_id}; 
  
  my $album = $self->fetch_by_uri_and_artist_id($args->{uri}, $args->{artist_id});
  
  if (!$album) {
    $self->insert({ 
      slug      => slug($args->{name}),
      name      => $args->{name},
      uri       => $args->{uri},
      image     => $args->{image},
      artist_id => $args->{artist_id},
    });
    $album = $self->fetch_by_uri_and_artist_id($args->{uri}, $args->{artist_id});
    $album->{_created} = 1;
  }

  return $album;
}

1;