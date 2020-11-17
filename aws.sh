: << !
# create instances
aws ec2 run-instances \
--image-id ami-0217058119427ee47 \
--instance-type t2.micro \
--count 1 \
--key-name txy \
--security-group-ids sg-c42e09ba \
--subnet-id subnet-14631a58 \
--tag-specifications 'ResourceType=instance,Tags=[{Key=tpc,Value=tpc}]' \
--network-interfaces 'AssociatePublicIpAddress=true,DeviceIndex=0' \
--placement 'GroupName = tpc'

# 存储优化 i3en.12xlarge 48CPU 384 内存 7.5T SSD * 4 50Gb网卡
# 计算优化 c5.metal 96CPU 192G 内存 无SSD 25Gb网卡


# get all public ips and private ips
export ips=`aws ec2 describe-instances --filters "Name=tag:tpc,Values=tpc" --query "Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[]"`
echo $ips


# terminate all instances
export instanceIds=`aws ec2 describe-instances --filters "Name=tag:tpc,Values=tpc" --query "Reservations[].Instances[].InstanceId"`
aws ec2 terminate-instances --instance-ids $instanceIds
!

# server info
serverPublicIP=18.191.193.128
serverPrivateIP=172.31.46.211
# client info
tpc1PublicIP=18.216.111.124

# tpc1PublicIP=
# tpc2PublicIP=
# tpc3PublicIP=
# tpc2PrivateIP=
# tpc3PrivateIP=

# init server

ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mkfs -t ext4 /dev/nvme1n1"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mkfs -t ext4 /dev/nvme2n1"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mkfs -t ext4 /dev/nvme3n1"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mkfs -t ext4 /dev/nvme4n1"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mount -t ext4 /dev/nvme1n1 /home/ubuntu/data/data1"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mount -t ext4 /dev/nvme2n1 /home/ubuntu/data/data2"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mount -t ext4 /dev/nvme3n1 /home/ubuntu/data/data3"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mount -t ext4 /dev/nvme4n1 /home/ubuntu/data/data4"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo chmod 777 /home/ubuntu/data/data1"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo chmod 777 /home/ubuntu/data/data2"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo chmod 777 /home/ubuntu/data/data3"
ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo chmod 777 /home/ubuntu/data/data4"
# sudo fdisk -l
# sudo df -h
# vim /etc/profile and ~/.bashrc change jdk from 8 to 11

#init tpc1
ssh -i ~/Desktop/txy.pem ubuntu@$tpc1PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$serverPrivateIP server1' >> /etc/hosts"
# ssh -i ~/Desktop/txy.pem ubuntu@$tpc1PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$serverPrivateIP server1' >> /etc/hosts && sudo echo '$tpc2PrivateIP tpc2' >> /etc/hosts && sudo echo '$tpc3PrivateIP tpc3' >> /etc/hosts"

#init tpc2 and tpc3
# ssh -i ~/Desktop/txy.pem ubuntu@$tpc2PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$serverPrivateIP server1' >> /etc/hosts"
# ssh -i ~/Desktop/txy.pem ubuntu@$tpc3PublicIP "sudo chmod 777 /etc/hosts && echo '$serverPrivateIP server1' >> /etc/hosts"