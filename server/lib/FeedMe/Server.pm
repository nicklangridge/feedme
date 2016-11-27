package FeedMe::Server;
use Mojo::Base 'Mojolicious';
use FeedMe::Config qw(config);
use FeedMe::Model::API;

sub startup {
  my $self = shift;
  
  $self->secrets(config->{mojo_secrets});

  $self->helper(feedme => sub { state $cache = FeedMe::Model::API->new });
  
  my $r = $self->routes;

  $r->get('/api/v1/latest' => sub {
    my $c = shift;
  
    my @args;
    push(@args, region   => $c->param('region'))              if $c->param('region');
    push(@args, offset   => $c->param('offset'))              if $c->param('offset');
    push(@args, limit    => $c->param('limit'))               if $c->param('limit');
    push(@args, genres   => [split /,/, $c->param('genres')]) if $c->param('genres');
    push(@args, feeds    => [split /,/, $c->param('feeds')])  if $c->param('feeds');
    push(@args, keywords => $c->param('keywords'))            if $c->param('keywords');

    $c->render(json => [ $c->feedme->latest(@args) ]);
  }); 
}

1;