package FeedMe::Model::Review;
use Moo;
use Method::Signatures;
use FeedMe::MySQL qw(dbh);
use FeedMe::Utils::Slug qw(slug);

method insert ($review!) {
  return dbh->insert('review', $review) || die dbh->error;
}

method fetch_by_album_and_feed ($album_id!, $feed_id!) {
  my ($row) = dbh->query('SELECT * FROM review WHERE album_id = ? AND feed_id = ?', $album_id, $feed_id)->hashes;
  return $row;
}

method fetch_or_create ($args!) {
  die 'album id is required' if !$args->{album_id};
  die 'feed id is required' if !$args->{feed_id};
  die 'url is required' if !$args->{url};
  
  my $review = $self->fetch_by_album_and_feed($args->{album_id}, $args->{feed_id});
  
  if (!$review) {
    $self->insert({ 
      album_id => $args->{album_id},
      feed_id  => $args->{feed_id},
      url      => $args->{url}
    });
    $review = $self->fetch_by_album_and_feed($args->{album_id}, $args->{feed_id});
    $review->{_created} = 1;
  }

  return $review;
}

1;