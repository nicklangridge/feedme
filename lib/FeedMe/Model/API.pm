package FeedMe::Model::API;
use Moo;
use Method::Signatures;
use FeedMe::MySQL qw(dbh);
use FeedMe::Utils::Slug qw(slug);

method latest ($args!) {
  $args->{region} ||= 'GB'; 
  $args->{limit}  ||= 30;
  $args->{offset} ||= 0;
  
  SELECT * FROM
}

1;