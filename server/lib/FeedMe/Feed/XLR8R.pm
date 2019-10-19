package FeedMe::Feed::XLR8R;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;
use Data::Dumper;

with 'FeedMe::Role::Feed::XML';

sub name         { 'XLR8R' };
sub url          { 'https://xlr8r.com/category/reviews/feed' };
sub homepage_url { 'https://www.xlr8r.com' };

sub parallel_parsers { 3 };

method parse_entry ($entry) {
  # warn $entry->link;
  # pick out the artist and album name from the html of the article
  my $html   = $self->_get($entry->link) || die "Failed to fetch page [" . $entry->link . "]: $!\n";
  my $dom    = Mojo::DOM->new($html)     || die "Failed to parse html: $!\n";    
  my $title  = eval { $dom->at('.page-header h1')->text }   || '';
  return {
    title   => $title,
    url     => trim $entry->link,
  }
}

method extract_artist_and_album ($title) {
  # warn $title;
  $title =~ s/\s+/ /g;
  $title =~ /(.+?)\s+['\x{2018}\x{201c}](.+)['\x{2019}\x{201d}]/;
  return {
    artist => trim $1, 
    album  => trim $2
  };
}

1;
