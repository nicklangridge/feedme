package FeedMe::Model::Genres;
use Moo;
use Method::Signatures;
use Data::Dumper;

my $GENRES = {
  'electronic' => [qw(
    indietronica
    fluxwork         
    microhouse 
    minimal-techno   
    outsider-house   
    bass-music       
    electronic       
    dance-pop        
    new-rave  
    fourth-world
    mandible
    intelligent-dance-music
    alternative-dance 
    float-house 
    dub-techno               
    electra                  
    wonky                          
    edm                     
    detroit-techno          
    tech-house              
    trip-hop                
    downtempo              
    electroclash           
    big-beat               
    tropical-house
    drill-and-bass
    uk-garage               
    acid-house              
    industrial              
    ninja                   
    vapor-twitch           
    minimal                
    electro-house          
    german-techno
    vaporwave
    techno                 
    glitch                 
    minimal-tech-house     
    deep-house             
    electro
    uk-funky
  )],
  'hip-hop-rap' => [qw(
    rap
    hip-hop
    southern-hip-hop     
    alternative-hip-hop      
    underground-hip-hop
    gangster-rap
    trap-music
    hip-pop                
    hardcore-hip-hop       
    atl-hip-hop            
    grime                  
    conscious-hip-hop      
    east-coast-hip-hop      
    uk-alternative-hip-hop  
    uk-hip-hop              
    drill                  
    abstract-hip-hop       
    boom-bap            
    dirty-south-rap        
    chicago-rap  
    miami-hip-hop
  )],
  'pop' => [qw(
    pop
    art-pop
    chamber-pop
    indie-pop
    pop-rap
    noise-pop
    electropop
    dream-pop
    experimental-pop         
    pop-rock     
    pop-punk                
    post-teen-pop           
    new-wave-pop     
    shimmer-pop            
    popgaze  
    jangle-pop              
    power-pop               
    twee-pop                
    neo-synthpop           
    icelandic-pop          
    garage-pop             
    etherpop               
    candy-pop              
    europop                
    synthpop                        
    alternative-pop   
    canadian-pop           
    mande-pop              
    afropop  
  )],
  'rock-indie' => [qw(
    modern-rock
    indie-rock
    alternative-rock
    neo-psychedelic
    preverb
    rock
    chamber-psych
    escape-room
    garage-rock      
    indie-punk       
    noise-rock       
    garage-psych   
    stomp-and-holler
    chillwave
    permanent-wave        
    drone                 
    slow-core                      
    dance-punk            
    nu-gaze
    dance-rock               
    art-rock                 
    future-garage            
    indie-garage-rock        
    experimental-rock                       
    singer-songwriter        
    modern-alternative-rock 
    new-wave
    mellow-gold
    alternative-metal       
    post-rock               
    emo                     
    post-hardcore           
    indie-psych-rock                      
    no-wave                
    britpop                
    brighton-indie         
    bay-area-indie         
    deep-new-americana     
    metal                  
    indie-surf             
    shoegaze               
    post-grunge            
    brooklyn-indie         
    classic-rock           
    nu-metal               
    lilith                 
    grave-wave             
    hard-rock              
    gbvfi                   
    album-rock              
    uk-post-punk            
    punk                    
    la-indie                
    english-indie-rock      
    post-punk               
    stoner-rock            
    glam-rock              
    thrash-metal           
    nz-indie               
    screamo                
    alternative-emo        
    modern-blues-rock      
    scottish-indie         
    mathcore               
    grindcore              
    death-metal            
    canadian-indie         
    drone-metal            
    punk-blues             
    new-jersey-indie       
    small-room             
    math-rock              
    soft-rock              
    crossover-thrash       
    speed-metal            
    psychedelic-rock       
    cleveland-indie        
    indie-poptimism        
    groove-metal           
    australian-indie       
    space-rock                            
    grunge                 
  )],
  'avant-garde' => [qw(
    avant-garde            
    experimental
    new-weird-america
    lo-fi
    sound-art
    abstractro
    acousmatic
    free-improvisation     
  )],
  'reggae-dub' => [qw(
    minimal-dub
    reggae
    dub
    dancehall
    roots-reggae
    traditional-reggae
  )],
  'country' => [qw(
    roots-rock
    new-americana
    alternative-country     
    country-rock                
    texas-country          
    roots-americana        
    outlaw-country         
  )],
  'folk' => [qw(
    folk
    freak-folk
    folk-pop
    indie-folk
    anti-folk
    drone-folk             
    traditional-folk       
    folk-rock              
    british-folk           
    canadian-folk          
  )],
  'randb' => [qw(
    indie-randb
    randb                    
    alternative-randb 
    urban-contemporary
    neo-soul
    deep-pop-randb         
  )],
  'soul-funk-jazz' => [qw(
    indie-jazz
    funk
    vocal-jazz             
    jazz                   
    contemporary-jazz      
    cool-jazz      
    contemporary-post-bop
    british-jazz           
  )],
  'ambient' => [qw(
    dark-jazz
    focus                  
    compositional-ambient
    ambient    
    warm-drone
    hauntology
    drift
  )],
};

my $PARENT_LOOKUP;
method parent_lookup () {
  if (!$PARENT_LOOKUP) {
    foreach my $parent (parent_genres()) {
      foreach my $sub ($self->sub_genres($parent)) {
        $PARENT_LOOKUP->{$sub} = $parent;
      }
    }
  }
  return $PARENT_LOOKUP;
}

method genres () {
  return $GENRES;
}

method parent_genres () {
  return sort keys %$GENRES; 
}

method sub_genres ($parent) {
  return @{ $GENRES->{$parent} }; 
}

method parent_genre ($sub_genre) {
  return $self->parent_lookup()->{$sub_genre};
}

method all_genres () {
  return keys %{ $self->parent_lookup() };
}



1;