# feedmemusic @  DigitalOcean
## MySQL droplet
- create a MySQL droplet
- create a feedme db user
- create db from SQL files in `server/sql/`
- load feeds with `./server/script/db/add_feeds.pl`
 
## Ubuntu 18.10 droplet

### update the OS
```
apt-get update && apt-get upgrade && sudo apt-get dist-upgrade
```
### create a feedme user
```
adduser feedme && usermod -aG sudo feedme
su feedme
```
### install some dependencies
```
sudo apt install -y nodejs && sudo apt install -y npm
sudo apt install -y cpanminus
sudo apt install -y libmysqlclient-dev
```

### create web path and user group
```
sudo mkdir /www
sudo gpasswd -a "$USER" www-data
sudo chown -R "$USER":www-data /var/www
sudo chown -R "$USER":www-data /www
find /www -type f -exec chmod 0660 {} \;
sudo find /www -type d -exec chmod 2770 {} \;
```
### checkout the code
```
cd /www
git clone https://github.com/nicklangridge/feedme.git
```

### set up the client
```
cd /www/feedme/client
cp config/prod.json.example config/prod.json # edit as needed
npm install
npm run prod
```

### set up the server
```
cd /www/feedme/server
sudo cpanm --installdeps .
cp config/dev.conf.example config/prod.conf # edit as needed
./scripts/server_control.pl start
```
### set up Nginx
```
sudo apt install -y nginx
sudo ufw allow 'Nginx HTTP'
sudo cp /www/feedme/deployment/digitalocean/nginx/feedmemusic.io /etc/nginx/sites-available/feedmemusic.io
sudo ln -s /etc/nginx/sites-available/feedmemusic.io /etc/nginx/sites-enabled/
```

### set up cron jobs
Install the cron from `deployment/digitalcoean/cron.txt`

### enjoy!