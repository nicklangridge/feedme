package FeedMe::Feed::COS;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::DOM';

sub name         { 'Consequence of Sound' };
sub url          { 'https://consequenceofsound.net/category/reviews/album-reviews/' };
sub homepage_url { 'https://consequenceofsound.net/' };

method parallel_parsers { 10 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  my %urls = map { $_ => 1 } grep {$_ =~ /.*consequenceofsound.net\/.+\/.+\/album-review.+/} @urls;
  
  return keys %urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html  = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom   = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $title = eval { $dom->at('title')->text } || '';
  
  $title = [split /\|/, $title]->[0];
  
  return {
    title   => trim $title,
    url     => trim $url,
  }
}

1;