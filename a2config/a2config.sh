#Absolute path of executed shellscript
SHELL_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

DOMAIN=$1

#Install apache2
apt install -y apache2

#Enable mods
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_wstunnel
a2enmod rewrite
a2enmod ssl

#Disable default apache site
a2dissite 000-default.conf

#Domain name setup
if [ ! -z "$DOMAIN" ]
then
    sed -i -e "s/bulochnik/$DOMAIN/g" ${SHELL_DIR}/*.conf
    rename "s/bulochnik/$DOMAIN/" ${SHELL_DIR}/*.conf
else
    DOMAIN='bulochnik'
fi

#Move .conf files to apache folder
for FILE in ${SHELL_DIR}/*.conf
do
    cp $FILE /etc/apache2/sites-available/
done

#Remove default /var/www/html
rm -rf /var/www/html

#Domain index.html
mkdir /var/www/$DOMAIN.com

cp $SHELL_DIR/index.html /var/www/$DOMAIN.com/

#Make ssl folder
mkdir /etc/apache2/ssl/

#Generate self signed SSL cert
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt \
    -subj "/C=US/ST=OR/L=Portland/O= /OU= /CN= "

#Enable sites
a2ensite $DOMAIN.com.conf
a2ensite dev.$DOMAIN.com.conf
a2ensite preview.$DOMAIN.com.conf
a2ensite jupyter.$DOMAIN.com.conf
