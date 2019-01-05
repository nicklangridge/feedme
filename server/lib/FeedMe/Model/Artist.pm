package FeedMe::Model::Artist;
use Moo;
use Method::Signatures;
use FeedMe::MySQL qw(dbh);
use FeedMe::Utils::Slug qw(slug);
use Data::Dumper;

method insert ($artist!) {
  warn "INSERT ARTIST\n";
  warn $artist->{name};
  return dbh->insert('artist', {%$artist, created => \"now()"}) || die dbh->error;
}

method fetch_by_uri ($uri!) {
  my ($row) = dbh->query('SELECT * FROM artist WHERE uri = ?', $uri)->hashes;
  return $row;
}

method fetch_or_create ($args!) {
  die 'artist uri is required' if !$args->{uri}; 
  
  my $artist = $self->fetch_by_uri($args->{uri});
  
  if (!$artist) {
    $self->insert({ 
      slug => slug($args->{name}),
      name => $args->{name},
      uri  => $args->{uri}
    });
    $artist = $self->fetch_by_uri($args->{uri});
    $artist->{_created} = 1;
  }

  return $artist;
}

1;