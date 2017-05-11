#Absolute path of executed shellscript
SHELL_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

USERNAME=$1
PASSWD=$2

#Updating APT Repos + adding vim PPA
add-apt-repository ppa:jonathonf/vim
apt update

#Adding new yevgeny user, adding to group sudo
adduser --disabled-password --gecos "" $USERNAME
usermod -aG sudo yevgeny
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >>  /etc/sudoers #passwordless sudo

#Execute a2config shellscript
${SHELL_DIR}/a2config/a2config.sh

#Install apt packages
apt install -y \
    npm \
    vim \
    htop

#Install npm packages +Node
npm install -g n
n 6.10.1
npm install -g pm2

#Setup Dotfiles
su $USERNAME -c "git clone https://github.com/yevgenybulochnik/dotfiles.git ~/dotfiles"
su $USERNAME -c "~/dotfiles/install.sh"

su $USERNAME -c "mkdir ~/.ssh"
su $USERNAME -c "curl https://github.com/yevgenybulochnik.keys > ~/.ssh/authorized_keys"
su $USERNAME -c "sudo npm install -g tty.js"
su $USERNAME -c "sudo pm2 start tty.js -- -p 8181"
su $USERNAME -c "sudo htpasswd -cb /etc/apache2/.htpasswd $USERNAME $PASSWD"
