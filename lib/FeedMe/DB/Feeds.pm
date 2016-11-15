package FeedMe::DB::Feeds;
use Moo;
use Method::Signatures;
use FeedMe::MySQL qw(dbh);

method all {
  return dbh->query('SELECT * FROM feed')->hashes;
}

method active {
  return dbh->query('SELECT * FROM feed WHERE active = 1')->hashes;
}

method public {
  return dbh->query('SELECT * FROM feed WHERE public = 1')->hashes;
}

method by_module ($module!) {
  my ($row) = dbh->query('SELECT * FROM feed WHERE module = ?', $module)->hashes;
  return $row;
}

method by_lug ($slug!) {
  my ($row) = dbh->query('SELECT * FROM feed WHERE slug = ?', $slug)->hashes;
  return $row;
}

method add ($feed!) {
  dbh->insert('feed', $feed) || die dbh->error;
}

1;