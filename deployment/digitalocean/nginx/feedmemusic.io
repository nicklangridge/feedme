server {
  listen 80;
  listen [::]:80;

  root /www/feedme/client/build;
  index index.html;

  server_name feedmemusic.io www.feedmemusic.io;

  location /api/ {
    proxy_pass http://localhost:8081;
  }

  location / {
    try_files $uri /index.html;
  }
}
