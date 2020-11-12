sudo chmod 777 /etc/hosts
sudo echo "$1 tpc1" >> /etc/hosts
sudo echo "$2 tpc2" >> /etc/hosts
sudo echo "$3 tpc3" >> /etc/hosts
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub tpc1
ssh-copy-id -i ~/.ssh/id_rsa.pub tpc2
ssh-copy-id -i ~/.ssh/id_rsa.pub tpc3