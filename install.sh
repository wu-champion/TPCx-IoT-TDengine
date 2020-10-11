sudo apt-get install clustershell
sudo chmod 777 /etc/clustershell/
sudo echo "all:tpc,tpc1" > /etc/clustershell/groups
sudo chmod 777 /etc/hosts
sudo echo "$1 tpc" >> /etc/hosts
sudo echo "$2 tpc1" >> /etc/hosts
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub tpc
ssh-copy-id -i ~/.ssh/id_rsa.pub tpc1