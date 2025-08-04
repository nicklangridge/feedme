# Feed Me Music

The latest music album reviews for Spotify listeners, gathered together from the best review sites on the web.
http://feedmemusic.app

## Quick-start

### Web UI

The UI is in a separate repo: https://github.com/nicklangridge/feedme-ui

### API server

This is a Mojolicious (Perl) web server and management scripts - it requires a MySQL database (more below).
```
cd server
cpanm --installdeps . 
morbo --listen "http://*:8081" script/server.pl
```
Find some album reviews.
```
./script/harvest.pl
```
### MySQL Database
Create from SQL in `server/sql` then initialise the review feeds
```
./server/script/db/add_feeds.pl
```
## Production deployment

There are lots of possible deployment options. A basic example can be found [here](deployment/digitalocean/README.md)

## External dependencies
API keys from these services are required
- [Spotify metadata API](https://developer.spotify.com/documentation/web-api/)
- [Mercury web parser API](https://mercury.postlight.com/web-parser/)
