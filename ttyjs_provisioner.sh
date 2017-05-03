#Updating APT Repos
apt update

#Adding new yevgeny user, adding to group sudo
adduser --disabled-password --gecos "" yevgeny
usermod -aG sudo yevgeny
echo "yevgeny ALL=(ALL) NOPASSWD:ALL" >>  /etc/sudoers #passwordless sudo
