#Absolute path of executed shellscript 
SHELL_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

#Updating APT Repos
apt update

#Adding new yevgeny user, adding to group sudo
adduser --disabled-password --gecos "" yevgeny
usermod -aG sudo yevgeny
echo "yevgeny ALL=(ALL) NOPASSWD:ALL" >>  /etc/sudoers #passwordless sudo

#Execute a2config shellscript
${DIR}/a2config/a2config.sh
