package FeedMe::MySQL;
use DBIx::Connector;
use DBIx::Simple::Inject;
use FeedMe::Config qw(config);
use strict;
use warnings;

use parent qw(Exporter);
our @EXPORT_OK = qw( conn dbh );

my $conn;

sub conn {
  $conn ||= DBIx::Connector->new( 
    config->{mysql}->{dsn}, 
    config->{mysql}->{user}, 
    config->{mysql}->{pass}, 
    { 
      AutoCommit        => 1, 
      mysql_enable_utf8 => 1,
      RootClass         => 'DBIx::Simple::Inject',
    } 
  );
  return $conn;
}

sub dbh {
  return conn->dbh;
}

1;