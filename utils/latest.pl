use strict;
use warnings;
use feature 'say';
use lib 'lib';
use FeedMe::MySQL 'dbh';
use Data::Dumper::Concise;

my $sql = q(

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
  WHERE 
    reg.region = ? 
    AND reg.active = 1
    AND gen.genre IN ('folk', 'techno')
  GROUP BY 
    al.album_id
  ORDER BY 
    reg.created DESC
  LIMIT 10
  
);

my @latest = dbh->query($sql, 'GB')->hashes;

say Dumper(\@latest);
