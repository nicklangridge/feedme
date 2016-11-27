use Test::Most;

BEGIN { 
  use_ok 'FeedMe::MySQL';
}

my $conn = FeedMe::MySQL::conn;
isa_ok $conn, 'DBIx::Connector', 'conn';

my $dbh = FeedMe::MySQL::dbh;
isa_ok $dbh, 'DBIx::Simple::Inject::db', 'dbh';

my $nums = $dbh->query('SELECT 1, 2, 3')->array;
is_deeply $nums, [1, 2, 3], 'array query returns arrayref';  

done_testing();