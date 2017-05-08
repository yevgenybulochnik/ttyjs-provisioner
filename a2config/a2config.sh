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

#Move .htpasswd file
cp ${SHELL_DIR}/.htpasswd /etc/apache2

#Remove default /var/www/html
rm -rf /var/www/html

#Bulochnik.com index.html
mkdir /var/www/bulochnik.com

cp $SHELL_DIR/index.html /var/www/bulochnik.com/

#Enable sites
a2ensite bulochnik.com.conf
a2ensite dev.bulochnik.com.conf
a2ensite preview.bulochnik.com.conf
