#Absolute path of executed shellscript
SHELL_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

#Install apache2
apt install -y apache2

#Enable mods
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_wstunnel
a2enmod rewrite

#Disable default apache site
a2dissite 000-default.conf

#Move .conf files to apache folder
for FILE in ${SHELL_DIR}/*.conf
do
    cp $FILE /etc/apache2/sites-available/
done

#Remove default /var/www/html
rm -rf /var/www/html

#Bulochnik.com index.html
mkdir /var/www/bulochnik.com

cp $SHELL_DIR/index.html /var/www/bulochnik.com/

#Make ssl folder
mkdir /etc/apache2/ssl/

#Generate self signed SSL cert
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt \
    -subj "/C=US/ST=OR/L=Portland/O= /OU= /CN= "

#Enable sites
a2ensite bulochnik.com.conf
a2ensite dev.bulochnik.com.conf
a2ensite preview.bulochnik.com.conf
a2ensite jupyter.bulochnik.com.conf
