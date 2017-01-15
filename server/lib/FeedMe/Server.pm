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
  
    my $region = $c->param('region');
    
    if (!$region) {
      $region = $c->geo_ip->country_code_by_addr($c->client_ip) || 'GB';
    }
  
    my @args;
    push(@args, region   => $region);
    push(@args, offset   => $c->param('offset'))              if $c->param('offset');
    push(@args, limit    => $c->param('limit'))               if $c->param('limit');
    push(@args, genres   => [split /,/, $c->param('genres')])  if $c->param('genres');
    push(@args, feeds    => [split /,/, $c->param('feeds')])   if $c->param('feeds');
    push(@args, keywords => $c->param('keywords'))            if $c->param('keywords');

    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->feedme->albums(@args));
  }); 
  
  $r->get('/api/v1/regions' => sub {
    my $c = shift;
    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->feedme->regions);
  }); 
  
  $r->get('/api/v1/feeds' => sub {
    my $c = shift;
    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->feedme->feeds);
  }); 
}

1;