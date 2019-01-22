package FeedMe::Model::MusicStory;
use Moo;
use Method::Signatures;
use FeedMe::MySQL qw(dbh);
use FeedMe::Metadata::MusicStory;

method fetch_artist_genres ($artist_name!) {
  my @genres;
  
  my ($row) = dbh->query('SELECT * FROM musicstory_genres WHERE artist_name = ?', $artist_name)->hashes;
  
  if ($row) {

    #warn "get MusicStory genres from db";
    @genres = split(/\|/, $row->{genres});
  
  } else {
    
    warn "fetching genres from MusicStory...\n";
    my $musicstory = FeedMe::Metadata::MusicStory->new;
    @genres = $musicstory->get_artist_genres($artist_name);
    
    dbh->query(
      'INSERT INTO musicstory_genres SET artist_name = ?, genres = ?, updated = now()', 
      $artist_name, 
      join('|', @genres),
    );
     
  }

  @genres = map {lc} @genres;
    
  #warn join(", ", @genres);
  return @genres;
}

1;