## Setup Nginx as reverse proxy 

```
scp ./proxy jalal@<IP>:~
ssh jalal@<IP>

sudo cp ./proxy /etc/nginx/sites-available/proxy
sudo ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/

sudo rm /etc/nginx/sites-enabled/default

sudo service nginx status 
sudo service nginx restart 

```

