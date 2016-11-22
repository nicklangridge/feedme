package FeedMe::Server;
use Mojo::Base 'Mojolicious';
use FeedMe::Config qw(config);
use FeedMe::Model::API;

sub startup {
  my $self   = shift;
  my $config = config();
  
  $self->secrets($config->{mojo_secrets});
  
  $self->helper(config => sub { state $cache = $config });
  $self->helper(feedme => sub { state $cache = FeedMe::Model::API->new });
  
  my $r = $self->routes;

  $r->any('/latest' => sub {
    my $c = shift;
    $c->render(json => [ $c->feedme->latest(limit => 5) ]);
  }); 
}

1;