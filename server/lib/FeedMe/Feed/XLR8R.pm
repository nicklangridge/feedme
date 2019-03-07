package FeedMe::Feed::XLR8R;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;
use Data::Dumper;

with 'FeedMe::Role::Feed::XML';

sub name         { 'XLR8R' };
sub url          { 'https://www.xlr8r.com/.rss/full/reviews' };
sub homepage_url { 'https://www.xlr8r.com' };

sub parallel_parsers { 3 };

method parse_entry ($entry) {
  #warn $entry->link;
  # pick out the artist and album name from the html of the article
  my $html   = $self->_get($entry->link) || die "Failed to fetch page [" . $entry->link . "]: $!\n";
  my $dom    = Mojo::DOM->new($html)     || die "Failed to parse html: $!\n";    
  my $title  = eval { $dom->at('h1.m-detail-header--title')->text }   || '';
  return {
    title   => $title,
    url     => trim $entry->link,
  }
}

method extract_artist_and_album ($title) {
  #warn $title;
  $title =~ s/\s+/ /g;
  $title =~ /(.+?)\s+'(.+)'/;
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

1;