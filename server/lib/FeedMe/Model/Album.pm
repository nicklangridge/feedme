package FeedMe::Model::Album;
use Moo;
use Method::Signatures;
use Clone qw(clone);
use DateTime;
use List::MoreUtils qw(uniq);
use FeedMe::MySQL qw(dbh);
use FeedMe::Utils::Slug qw(slug);
use Data::Dumper;

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

method fetch_by_slug_and_artist ($slug!, $artist_id!) {
  my ($row) = dbh->query('SELECT * FROM album WHERE slug = ? AND artist_id = ?', $slug, $artist_id)->hashes;
  return $row;
}

method fetch_all_regions ($album_id!) {
  return dbh->query('SELECT * FROM album_region WHERE album_id = ?', $album_id)->hashes;
}

method fetch_all_genres ($album_id!) {
  return dbh->query('SELECT * FROM album_genre WHERE album_id = ?', $album_id)->hashes;
}

method fetch_for_update ($limit = 10) {
  return dbh->query('SELECT * FROM album ORDER BY checked ASC LIMIT ' . int($limit))->hashes;
}

method fetch_newest ($limit = 10) {
  return dbh->query('SELECT * FROM album ORDER BY created DESC LIMIT ' . int($limit))->hashes;
}

method fetch_or_create ($args!) {
  die 'album name is required' if !$args->{name}; 
  die 'artist_id is required'  if !$args->{artist_id}; 
  
  my $slug = slug($args->{name});
  my $album = $self->fetch_by_slug_and_artist($slug, $args->{artist_id});
  
  if (!$album) {
    $self->insert({ 
      slug      => $slug,
      name      => $args->{name},
      uri       => $args->{uri},
      image     => $args->{image},
      artist_id => $args->{artist_id},
      keywords  => $args->{keywords},
    });
    $album = $self->fetch_by_slug_and_artist($slug, $args->{artist_id});
    $album->{_created} = 1;
    
    $self->set_genres($album->{album_id}, $args->{genres})   if $args->{genres};
    $self->set_regions($album->{album_id}, $args->{regions}) if $args->{regions};
  }

  return $album;
}

method set_genres ($album_id!, $genres!) {
  
  my %unique = map{ slug($_) => $_ } @$genres;
  $genres = [values %unique];
  
  my @old = map {$_->{name}} $self->fetch_all_genres($album_id);
  my $updated = 0;
  
  if (!$self->_array_equal(\@old, $genres)) {

    dbh->query('DELETE FROM album_genre WHERE album_id = ?', $album_id);
    foreach my $genre (@$genres) {
      dbh->insert('album_genre', {album_id => $album_id, name => $genre, slug => slug($genre)}) || die dbh->error;
    }
    
    $updated = 1;
  }
  
  return $updated;
}

method set_regions ($album_id!, $regions!) {  
  my %new = map {$_ => 1} @$regions;
  my %old = map {$_->{region} => $_} $self->fetch_all_regions($album_id);
  my $now = DateTime->now;
  my %combined;
  my $updated = 0;
  
  if (!$self->_array_equal([keys %old], [keys %new])) {
  
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
    
    $updated = 1;
  } 
  
  return $updated;
}

method fetch_where ($where) {
  return dbh->select('album', '*', $where)->hashes;
}

method _array_equal ($a!, $b!) {
  #warn '_array_equal: [' . lc(join(':', sort @$a )) . '] eq [' . lc(join(':', sort @$b )) . "]\n";
  return lc(join(':', sort @$a )) eq lc(join(':', sort @$b )); 
}

1;