package FeedMe::Feed::XSNoize;
use Moo;
use Method::Signatures;
use Text::Trim;

with 'FeedMe::Role::Feed::DOM';

sub name         { 'XS Noize' };
sub url          { 'https://www.xsnoize.com/reviews/album-reviews/' };
sub homepage_url { 'https://www.xsnoize.com' };

method parallel_parsers { 10 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  my %urls = map { $_ => 1 } grep {$_ =~ /.*www\.xsnoize\.com\/album-review.+/} @urls;
  
  return keys %urls;
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html  = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom   = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $title = eval { $dom->at('title')->text } || '';
  
  $title = [split /\|/, $title]->[0];
  $title =~ s/ALBUM REVIEW://;
  
  return {
    title   => trim $title,
    url     => trim $url,
  }
}

1;