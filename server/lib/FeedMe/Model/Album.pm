package FeedMe::Model::Album;
use Moo;
use Method::Signatures;
use Clone qw(clone);
use DateTime;
use FeedMe::MySQL qw(dbh);
use FeedMe::Utils::Slug qw(slug);

method insert ($album!) {
  return dbh->insert('album', {%$album, created => \"now()", checked => \"now()"}) || die dbh->error;
}

method save ($album!) {
  delete $album->{_created};
  my $id = delete $album->{album_id} || die 'album_id is required';
  return dbh->update('album', $album, {album_id => $id}) || die dbh->error;
}

method fetch_by_uri_and_artist ($uri!, $artist_id!) {
  my ($row) = dbh->query('SELECT * FROM album WHERE uri = ? AND artist_id = ?', $uri, $artist_id)->hashes;
  return $row;
}

method fetch_all_regions ($album_id!) {
  return dbh->query('SELECT * FROM album_region WHERE album_id = ?', $album_id)->hashes;
}

method fetch_or_create ($args!) {
  die 'album uri is required' if !$args->{uri}; 
  die 'artist_id is required'  if !$args->{artist_id}; 
  
  my $album = $self->fetch_by_uri_and_artist($args->{uri}, $args->{artist_id});
  
  if (!$album) {
    $self->insert({ 
      slug      => slug($args->{name}),
      name      => $args->{name},
      uri       => $args->{uri},
      image     => $args->{image},
      artist_id => $args->{artist_id},
      keywords  => $args->{keywords},
    });
    $album = $self->fetch_by_uri_and_artist($args->{uri}, $args->{artist_id});
    $album->{_created} = 1;
    
    $self->set_genres($album->{album_id}, $args->{genres})   if $args->{genres};
    $self->set_regions($album->{album_id}, $args->{regions}) if $args->{regions};
  }

  return $album;
}

method set_genres ($album_id!, $genres!) {
  dbh->query('DELETE FROM album_genre WHERE album_id = ?', $album_id);
  foreach my $genre (@$genres) {
    dbh->insert('album_genre', {album_id => $album_id, name => $genre, slug => slug($genre)}) || die dbh->error;
  }
}

method set_regions ($album_id!, $regions!) {  
  my %new = map {$_ => 1} @$regions;
  my %old = map {$_->{region} => $_} $self->fetch_all_regions($album_id);
  my $now = DateTime->now;
  my %combined;
  
  foreach my $r (keys %new) {
    if (!exists $combined{$r}) {
      # new or still active - add or keep
      $combined{$r} = {
        album_id => $album_id,
        region   => $r, 
        created  => (exists $old{$r}) ? $old{$r}->{created} : $now,
        active   => 1,
      };
    } 
  } 
  
  foreach my $r (keys %old) {
    if (!$combined{$r}) {
      # no longer active - keep but deactivate
      $combined{$r} = clone($old{$r});
      $combined{$r}->{active} = 0;
    }
  }
  
  dbh->query('DELETE FROM album_region WHERE album_id = ?', $album_id);
  
  foreach my $row (values %combined) {
    dbh->insert('album_region', $row) || die dbh->error;
  }
}

method fetch_where ($where) {
  return dbh->select('album', '*', $where)->hashes;
}

1;