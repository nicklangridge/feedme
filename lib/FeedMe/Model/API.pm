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
  
  return @latest;
}

method quote (@values) {
  return map {dbh->quote($_)} @values;
}

1;
