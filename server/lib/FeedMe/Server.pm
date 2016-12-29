package FeedMe::Server;
use Mojo::Base 'Mojolicious';
use FeedMe::Config qw(config);
use FeedMe::Model::API;
use Geo::IP;

sub startup {
  my $self = shift;
  
  $self->secrets(config->{mojo_secrets});
  
  $self->plugin('ClientIP');
  
  $self->helper(feedme => sub { state $cache = FeedMe::Model::API->new });
  $self->helper(geo_ip => sub { state $cache = Geo::IP->new });
  
  my $r = $self->routes;

  $r->get('/api/v1/albums' => sub {
    my $c = shift;
  
    my @args;
    push(@args, region   => $c->param('region'))              if $c->param('region');
    push(@args, offset   => $c->param('offset'))              if $c->param('offset');
    push(@args, limit    => $c->param('limit'))               if $c->param('limit');
    push(@args, genres   => [split /,/, $c->param('genre')])  if $c->param('genre');
    push(@args, feeds    => [split /,/, $c->param('feed')])   if $c->param('feed');
    push(@args, keywords => $c->param('keywords'))            if $c->param('keywords');

    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => [ $c->feedme->albums(@args) ]);
  }); 
  
  $r->get('/api/v1/client_region' => sub {
    my $c = shift;
    my $ip = $c->client_ip;
    my $region = $c->geo_ip->country_code_by_addr($ip) || 'GB';

    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => {
      region => $region,
      ip => $ip
    });
  }); 
}

1;