package FeedMe::Server;
use Mojo::Base 'Mojolicious';
use FeedMe::Config;
use FeedMe::Model;

sub startup {
  my $self   = shift;
  my $config = FeedMe::Config->new;
  
  $self->secrets($config->{mojo_secrets});
  
  $self->helper(config => sub { state $cache = $config });
  $self->helper(model  => sub { state $cache = FeedMe::Model->new });
  
  my $r = $self->routes;

  $r->any('/' => sub {
    my $c = shift;
    $self->render(json => {message => 'hello'});
  } 
}