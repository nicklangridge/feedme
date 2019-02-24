package FeedMe::Model::API;
use Moo;
use Method::Signatures;
use FeedMe::MySQL 'dbh';
use FeedMe::Utils::Slug 'slug';
use FeedMe::Model::Genres;
use Data::Dumper;


method regions () {
  return [ dbh->query('SELECT DISTINCT(region) FROM album_region ORDER by region')->flat ];
}

method feeds () {
  return [ dbh->query('SELECT name, slug, homepage_url FROM feed WHERE active = 1 ORDER by name')->hashes ];
}

method albums (:$region = 'GB', :$offset = 0, :$limit = 30, 
               :$genres = undef, :$feeds = undef, :$keywords = undef, :$category = undef) {
  
  my @filters;
  
  my $join = '';
  $join  .= (($genres && @$genres) || $category) ? 'JOIN album_genre gen USING(album_id)' : '';
  $join  .= $feeds && @$feeds ? 'JOIN review r USING(album_id) JOIN feed f USING(feed_id)'  : '';
  
  my $where = '';
  $where .= $category ? sprintf("AND gen.parent = \%s", join(',', $self->quote($category))) : '';
  $where .= $genres && @$genres ? sprintf("AND gen.slug IN (\%s)", join(',', $self->quote(@$genres))) : '';
  $where .= $feeds && @$feeds  ? sprintf("AND f.slug   IN (\%s)", join(',', $self->quote(@$feeds)))  : '';
  $where .= $keywords ? sprintf("AND MATCH (keywords) AGAINST (\%s IN BOOLEAN MODE)", $self->quote($keywords)) : '';
  
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
      JOIN album_region reg USING(album_id)
      $join
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

#warn "SQL\n$sql\n[$region]";

  my @albums = dbh->query($sql, $region)->hashes;
    
  if (@albums) {
    # add in genres and reviews
    my @album_ids     = map {$_->{album_id}} @albums;
    my $album_ids_in  = join ',', $self->quote(@album_ids);
    my $genre_lookup  = $self->_get_genre_lookup($album_ids_in);
    my $review_lookup = $self->_get_review_lookup($album_ids_in);
    
    foreach (@albums) {
      $_->{genres}  = $genre_lookup->{$_->{album_id}}  || [];
      $_->{reviews} = $review_lookup->{$_->{album_id}} || [];
    }
    
    # filters 
    if ($category) {
      my $genres_model = FeedMe::Model::Genres->new;
      push @filters, {type => 'category', slug => $category, name => $genres_model->parent_name($category)};
    }
    if ($genres && @$genres) {
      push @filters, map {{type => 'genre', slug => $_, name => $genre_lookup->{genre_name}->{$_}}} @$genres;
    }
    if ($feeds && @$feeds) {
      push @filters, map {{type => 'feed', slug => $_, name => $review_lookup->{feed_name}->{$_}}} @$feeds;
    }  
  }

  if ($keywords) {
    push @filters, {type => 'search', slug => $keywords, name => $keywords};
  }
  
  my $result = { 
    albums => \@albums, 
    region => $region,
  };
  $result->{filters} = \@filters if @filters;

#warn Dumper $result;
  
  return $result;
}

method quote (@values) {
  return map {dbh->quote($_)} @values;
}

method _get_genre_lookup ($album_ids_in) {
  my @rows = dbh->query(qq(
    SELECT album_id, name, slug, parent 
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
    $lookup{genre_name}->{$_->{slug}} = $_->{name};
  }
  
  return \%lookup;
}

method _get_review_lookup ($album_ids_in) {
  my @rows = dbh->query(qq(
    SELECT f.name, f.slug, r.album_id, r.url, r.snippet 
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
    $lookup{feed_name}->{$_->{slug}} = $_->{name};
  }
  
  return \%lookup;
}

1;
