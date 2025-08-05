package FeedMe::Server;
use Mojo::Base 'Mojolicious';
use FeedMe::Config qw(config);
use FeedMe::Model::API;
use FeedMe::Metadata::LastFM;
use Geo::IP;

sub startup {
  my $self = shift;
  
  $self->secrets(config->{mojo_secrets});
  
  $self->plugin('ClientIP');
  
  $self->helper(feedme => sub { state $cache = FeedMe::Model::API->new });
  $self->helper(lastfm => sub { state $cache = FeedMe::Metadata::LastFM->new });
  $self->helper(geo_ip => sub { state $cache = Geo::IP->new });
  
  my $r = $self->routes;

  $r->get('/api/v1/albums' => sub {
    my $c = shift;
  
    my $region = $c->param('region');
    
    if (!$region) {
      #$region = $c->geo_ip->country_code_by_addr($c->client_ip) || 'GB';
      $region = 'GB';
    }
  
    my @args;
    push(@args, region   => $region);
    push(@args, offset   => $c->param('offset'))              if $c->param('offset');
    push(@args, limit    => $c->param('limit'))               if $c->param('limit');
    push(@args, genres   => [split /,/, $c->param('genres')]) if $c->param('genres');
    push(@args, feeds    => [split /,/, $c->param('feeds')])  if $c->param('feeds');
    push(@args, keywords => $c->param('keywords'))            if $c->param('keywords');
    push(@args, category => $c->param('category'))            if $c->param('category');

    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->feedme->albums(@args));
  }); 

  $r->get('/api/v1/album/:album_id' => sub {
      my $c = shift;
      my $album_id = $c->param('album_id');
      $c->res->headers->access_control_allow_origin('*');
      $c->render(json => $c->feedme->album($album_id));
  }); 
  
  $r->get('/api/v1/regions' => sub {
    my $c = shift;
    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->feedme->regions);
  });
  
  $r->get('/api/v1/top-genres' => sub {
    my $c = shift;
    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->feedme->top_genres);
  }); 
  
  $r->get('/api/v1/feeds' => sub {
    my $c = shift;
    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->feedme->feeds);
  }); 
  
  $r->get('/api/v1/artist-info/:artist_name' => sub {
    my $c = shift;
    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->lastfm->get_artist_info($c->param('artist_name')));
  });
  
  $r->get('/api/v1/related-genres/:genre' => sub {
    my $c = shift;
    $c->res->headers->access_control_allow_origin('*');
    $c->render(json => $c->feedme->related_genres($c->param('genre')));
  });
}

1;