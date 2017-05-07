#Absolute path of executed shellscript
SHELL_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

#Updating APT Repos
apt update

#Adding new yevgeny user, adding to group sudo
adduser --disabled-password --gecos "" yevgeny
usermod -aG sudo yevgeny
echo "yevgeny ALL=(ALL) NOPASSWD:ALL" >>  /etc/sudoers #passwordless sudo

#Execute a2config shellscript
${SHELL_DIR}/a2config/a2config.sh

#Install apt packages
apt install -y \
    npm \
    htop 

#Install npm packages +Node
npm install -g n 
n 6.10.1
npm install -g pm2 

#Setup Dotfiles

su yevgeny -c "git clone https://github.com/yevgenybulochnik/dotfiles.git ~/dotfiles"
su yevgeny -c "~/dotfiles/install.sh"

su yevgeny -c "mkdir ~/.ssh"
su yevgeny -c "curl https://github.com/yevgenybulochnik.keys > ~/.ssh/authorized_keys"
