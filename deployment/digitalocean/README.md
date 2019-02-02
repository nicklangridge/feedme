# feedmemusic on DigitalOcean

This is a basic example of how to deploy on DigitalOcean. This example uses two droplets, one for the MySQL database, and one to run the client app and API server using an Nginx reverse-proxy.

## MySQL droplet
- create a MySQL droplet
- create a feedme db user
- create db from SQL files in `server/sql/`
- load feeds with `./server/script/db/add_feeds.pl`
 
## Ubuntu droplet

Create an Ubuntu droplet using latest version

### Update the OS
```
apt-get update && apt-get upgrade && sudo apt-get dist-upgrade
```
### Create a feedme user
```
adduser feedme && usermod -aG sudo feedme
su feedme
```
### Istall some dependencies
```
sudo apt install -y nodejs npm
sudo apt install -y cpanminus
sudo apt install -y libmysqlclient-dev
```

### Create web path and user group
```
sudo mkdir /www
sudo gpasswd -a "$USER" www-data
sudo chown -R "$USER":www-data /var/www
sudo chown -R "$USER":www-data /www
find /www -type f -exec chmod 0660 {} \;
sudo find /www -type d -exec chmod 2770 {} \;
```
### Checkout the code
```
cd /www
git clone https://github.com/nicklangridge/feedme.git
```

### Set up the client
```
cd /www/feedme/client
cp config/prod.json.example config/prod.json # edit as needed
npm install
npm run prod
```

### Set up the server
```
cd /www/feedme/server
sudo cpanm --installdeps .
cp config/dev.conf.example config/prod.conf # edit as needed
./scripts/server_control.pl start
```
### Set up Nginx
```
sudo apt install -y nginx
sudo ufw allow 'Nginx HTTP'
sudo cp /www/feedme/deployment/digitalocean/nginx/feedmemusic.io /etc/nginx/sites-available/feedmemusic.io
sudo ln -s /etc/nginx/sites-available/feedmemusic.io /etc/nginx/sites-enabled/
```

### Set up cron jobs
Install the cron from `deployment/digitalcoean/cron.txt`

### Enjoy!