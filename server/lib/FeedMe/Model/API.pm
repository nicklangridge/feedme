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
      AND al.active = 1
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
    
    my $primary_feed = ($feeds && @$feeds) ? $feeds->[0] : undef;
    
    foreach (@albums) {
      $_->{genres}  = $genre_lookup->{$_->{album_id}}  || [];
      $_->{reviews} = $review_lookup->{$_->{album_id}} || [];
      # TODO: move this sorting to SQL
      if ($primary_feed) {
        $_->{reviews} = [ sort { $a->{slug} eq $primary_feed ? -1 : 1 } @{ $_->{reviews} } ]
      }      
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

  my $genre_hits;
  if ($keywords) {
    push @filters, {type => 'search', slug => $keywords, name => $keywords};
    $genre_hits = $self->_search_genres($keywords);
  }
  
  my $result = { 
    albums => \@albums, 
    region => $region,
    genres => $genre_hits || [],
  };
  $result->{filters} = \@filters if @filters;

 #warn Dumper $result;
 #warn Dumper $genre_hits;
  
  return $result;
}

method album ($album_id) {
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
      ar.uri  as artist_uri
    FROM album al
      JOIN artist ar USING(artist_id)
    WHERE 
      album_id = ?
  );
  my ($album) = dbh->query($sql, $album_id)->hashes;

  if ($album) {
    # add in genres and reviews 
    my $genre_lookup  = $self->_get_genre_lookup($album->{album_id});
    $album->{genres}  = $genre_lookup->{$album_id}  || [];

    my $review_lookup = $self->_get_review_lookup($album->{album_id});
    $album->{reviews} = $review_lookup->{$album_id} || [];
  }
  
  return $album;
}

method top_genres ($limit? = 50) {
  $limit = int($limit);
  
  my $sql = qq(
    SELECT name, slug, occurances as count
    FROM genre_index 
    ORDER BY occurances DESC 
    LIMIT $limit
  );
  
  return [ dbh->query($sql)->hashes ];
}

method related_genres ($genre!, $limit? = 20) {
  $limit = int($limit) + 1; # include the genre itself
  my $sql = qq(
    SELECT name, slug, count(*) as count 
    FROM album_genre 
    WHERE 
      album_id IN (SELECT album_id FROM album_genre WHERE slug = ?) 
    GROUP BY HAVING count > 3
    ORDER BY IF(slug = ?, 0, 1), count DESC
    LIMIT $limit;
  );
  my @rows = dbh->query($sql, $genre)->hashes;
  my $main_genre = shift @rows;
  return { genre => $main_genre, related => \@rows };
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

method _search_genres ($keywords, :$limit = 20) {
  $limit = int($limit) || 20;

  my @words = $self->quote(map {"$_%"} split /\s+/, $keywords);
  my @where;  
  foreach my $word (@words) {
    push @where, "(word1 like $word or word2 like $word or word3 like $word)";
  }
  my $where_str = join ' AND ', @where;
  
  my $sql = qq(
    SELECT name, slug, occurances FROM genre_index 
    WHERE $where_str
    ORDER BY occurances DESC
    LIMIT $limit;
  );

  return [ dbh->query($sql)->hashes ];
}

1;
