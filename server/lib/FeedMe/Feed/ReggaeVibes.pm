package FeedMe::Feed::ReggaeVibes;
use Moo;
use Method::Signatures;
use Mojo::DOM;
use Text::Trim;

with 'FeedMe::Role::Feed::DOM';

sub name         { 'Reggae Vibes' };
sub url          { 'https://www.reggae-vibes.com/category/reviews' };
sub homepage_url { 'https://www.reggae-vibes.com' };

method parallel_parsers { 3 }

method extract_entry_urls ($dom) {
  my @urls = @{ $dom->find('*')->map(attr => 'href')->compact };
  my %urls = map { $_ => 1 } grep {$_ =~ /.*www\..*\/reviews\/\d+\/\d+/} @urls;
  # keep 20 most recent (wroks because URLs are of form ".../yyyy/mm/...")
  # needed because otherwise we could get hundreds
  my @sorted_urls = reverse sort keys %urls;
  return @sorted_urls[0..19];
}

method parse_entry ($url) {
  # pick out the artist and album name from the html of the article
  my $html  = $self->_get($url)      || die "Failed to fetch page [$url]: $!\n";
  my $dom   = Mojo::DOM->new($html)  || die "Failed to parse html: $!\n";  
  my $title = eval { $dom->at('.entry-title')->all_text =~ s/[\r\n]//gr } || ''; 
  return {
    title   => trim $title,
    url     => trim $url,
  }
}

1;
