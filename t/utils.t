use Test::Most;
use utf8::all;

BEGIN { 
  use_ok 'FeedMe::Utils::Slug', qw(slug);
}

is slug(q("*I líke  slug's!)), 'i-like-slugs', 'slug';

done_testing();