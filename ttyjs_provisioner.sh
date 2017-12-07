#!/bin/bash
#Absolute path of executed shellscript
SHELL_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

USERNAME=$1
PASSWD=$2

#Updating APT Repos + adding vim PPA
add-apt-repository ppa:jonathonf/vim -y
apt update

#Adding new yevgeny user, adding to group sudo
adduser --disabled-password --gecos "" $USERNAME
usermod -aG sudo $USERNAME
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >>  /etc/sudoers #passwordless sudo

#Execute a2config shellscript
${SHELL_DIR}/a2config/a2config.sh

#Install apt packages
apt install -y \
    npm \
    vim \
    htop \
    python3-venv

#Install npm packages +Node
npm install -g n
n 6.10.1
npm install -g pm2

#Move python setup folder & permissions
cp -r ${SHELL_DIR}/pysetup/ /home/$USERNAME/
chown $USERNAME:$USERNAME -R /home/$USERNAME/pysetup/

#Setup Dotfiles, ttyjs, pm2, htpasswd
su $USERNAME <<COMMANDS
mkdir ~/.ssh
curl https://github.com/yevgenybulochnik.keys > ~/.ssh/authorized_keys
sudo npm install -g tty.js
sudo pm2 start tty.js --name "WebTerm" -- --port 8181
sudo htpasswd -cb /etc/apache2/.htpasswd $USERNAME $PASSWD
~/pysetup/pySetup.sh
git clone https://github.com/yevgenybulochnik/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
COMMANDS
