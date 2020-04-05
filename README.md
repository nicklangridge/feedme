![Feed Me Music](feedmemusic.png)

The latest music album reviews for Spotify listeners, gathered together from the best review sites on the web.
http://feedmemusic.io

## Quick-start

### Web client

The client is now in a separate repo: https://github.com/nicklangridge/feedme-client

This is a React app (it is based on Create React App)
```
cd feedme-client
npm install . 
npm start
```

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
