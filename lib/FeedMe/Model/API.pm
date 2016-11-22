package FeedMe::Model::API;
use Moo;
use Method::Signatures;
use FeedMe::MySQL 'dbh';
use FeedMe::Utils::Slug 'slug';

method latest (:$region = 'GB', :$offset = 0, :$limit = 30, :$genres = [], :$feeds = [], :$keywords = '') {
  
  my $where = '';
  $where .= @$genres  ? sprintf("AND gen.genre IN (\%s)", join(',', $self->quote(@$genres))) : '';
  $where .= @$feeds   ? sprintf("AND f.slug    IN (\%s)", join(',', $self->quote(@$feeds)))  : '';
  $where .= $keywords ? sprintf("AND MATCH (keywords) AGAINST (\%s)", $self->quote($keywords)) : '';
  
  my $sql = qq(
    SELECT 
      al.album_id,
      al.name as album_name,
      al.slug as album_slug,
      al.uri  as album_uri,
      al.image,
      ar.artist_id,
      ar.name as artist_name,
      ar.slug as artist_slug,
      ar.uri  as artist_uri,
      reg.created    
    FROM album al
      JOIN artist ar USING(artist_id)
      JOIN review r USING(album_id)
      JOIN album_region reg USING(album_id)
      JOIN album_genre gen USING(album_id)
      JOIN feed f USING(feed_id)
    WHERE 
      reg.region = ? 
      AND reg.active = 1
      $where
    GROUP BY 
      al.album_id
    ORDER BY 
      reg.created DESC
    LIMIT $offset, $limit
  );
  
  my @latest = dbh->query($sql, $region)->hashes;
  
  if (@latest) {
    # add in genres and reviews
    my @album_ids     = map {$_->{album_id}} @latest;
    my $album_ids_in  = join ',', $self->quote(@album_ids);
    my $genre_lookup  = $self->_get_genre_lookup($album_ids_in);
    my $review_lookup = $self->_get_review_lookup($album_ids_in);
    
    foreach (@latest) {
      $_->{genres}  = $genre_lookup->{$_->{album_id}};
      $_->{reviews} = $review_lookup->{$_->{album_id}};
    }
  }
  
  return @latest;
}

method quote (@values) {
  return map {dbh->quote($_)} @values;
}

method _get_genre_lookup ($album_ids_in) {
  my @rows = dbh->query(qq(
    SELECT album_id, name, slug 
    FROM album_genre 
    WHERE album_id IN ($album_ids_in) 
    ORDER BY album_id, name 
  ))->hashes;
  
  my %lookup;
  
  foreach (@rows) {
    my $key = $_->{album_id};
    $lookup{$key} ||= [];
    delete $_->{album_id};
    push @{$lookup{$key}}, $_;
  }
  
  return \%lookup;
}

method _get_review_lookup ($album_ids_in) {
  my @rows = dbh->query(qq(
    SELECT f.name, f.slug, r.album_id, r.url  
    FROM review r 
    JOIN feed f USING(feed_id) 
    WHERE r.album_id IN ($album_ids_in) 
    ORDER BY r.album_id, f.name 
  ))->hashes;
  
  my %lookup;
  
  foreach (@rows) {
    my $key = $_->{album_id};
    $lookup{$key} ||= [];
    delete $_->{album_id};
    push @{$lookup{$key}}, $_;
  }
  
  return \%lookup;
}

1;
