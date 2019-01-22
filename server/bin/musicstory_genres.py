#!/usr/bin/env python2

import sys
from music_story import MusicStoryApi

if len(sys.argv) < 4:
  sys.exit('Please supply args <key> <secret> <artist name>')

api_key = sys.argv[1]
api_secret = sys.argv[2]
artist_name = sys.argv[3]

api = MusicStoryApi(api_key, api_secret)
api.connect()

artists = api.search('artist', name=artist_name)

### TODO use spotify connector to check id here?

try:
  artist = artists[0]
except:
  sys.exit('Artist not found')

genres = artist.connector('genres')
for genre in genres: print genre.name
