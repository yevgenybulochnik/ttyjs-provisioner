#Install apache2
apt install -y apache2

#Enable mods
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_wstunnel
a2enmod rewrite

#Disable default apache site
a2dissite 000-default.conf

#Remove default /var/www/html
rm -rf /var/www/html
