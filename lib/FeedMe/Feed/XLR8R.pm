package FeedMe::Feed::XLR8R;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;
use feature 'say';

with 'FeedMe::Role::Feed::XML';

sub url { 'https://www.xlr8r.com/reviews/feed/' };

method parse_entry ($entry) {
    
  # pick out the artist and album name from the html of the article
  my $html   = $self->_get($entry->link) || die "Failed to fetch page [" . $entry->link . "]: $!\n";
  my $dom    = Mojo::DOM->new($html)     || die "Failed to parse html: $!\n";    
  my $artist = eval { $dom->at('h1.entry-title')->text }   || '';
  my $album  = eval { $dom->at('h1.entry-title i')->text } || '';
 
  return {
    title   => join(' - ', trim $artist, trim $album),
    url     => trim $entry->link,
  }
}

1;