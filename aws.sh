: << !
# create instances
aws ec2 run-instances \
--image-id ami-09a7c634fff4d295c \
--instance-type t2.micro \
--count 1 \
--key-name txy \
--security-group-ids sg-c42e09ba \
--subnet-id subnet-14631a58 \
--tag-specifications 'ResourceType=instance,Tags=[{Key=tpc,Value=tpc}]' \
--network-interfaces 'AssociatePublicIpAddress=true,DeviceIndex=0' \
--placement 'GroupName = tpc'

# 存储优化 i3en.12xlarge 48核CPU 384G 内存 7.5T SSD * 4 50Gb网卡
# 计算优化 c5.metal 96核CPU 192G 内存 无SSD 25Gb网卡
# 存储优化 i3.metal：64核CPU 512G内存 1.5T SSD*8 50Gb网卡
# 存储优化 i3en.metal：96核CPU 768G内存 7T SSD*8 100Gb网卡


# get all public ips and private ips
export ips=`aws ec2 describe-instances --filters "Name=tag:tpc,Values=tpc" --query "Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[]"`
echo $ips


# terminate all instances
export instanceIds=`aws ec2 describe-instances --filters "Name=tag:tpc,Values=tpc" --query "Reservations[].Instances[].InstanceId"`
aws ec2 terminate-instances --instance-ids $instanceIds
!

# server info
server1PublicIP=3.22.236.147
server1PrivateIP=172.31.39.201
# server2PublicIP=3.139.90.103
# server2PrivateIP=172.31.46.246
# client info
tpc1PublicIP=18.217.113.59
tpc2PublicIP=3.19.141.242
tpc3PublicIP=18.191.241.232
tpc2PrivateIP=172.31.45.51
tpc3PrivateIP=172.31.46.132

# init server

ssh -i ~/Desktop/txy.pem ubuntu@$server1PublicIP "sudo mkfs -t ext4 /dev/nvme1n1"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mkfs -t ext4 /dev/nvme2n1"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mkfs -t ext4 /dev/nvme3n1"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mkfs -t ext4 /dev/nvme4n1"
ssh -i ~/Desktop/txy.pem ubuntu@$server1PublicIP "sudo mount -t ext4 /dev/nvme1n1 /home/ubuntu/data/data1"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mount -t ext4 /dev/nvme2n1 /home/ubuntu/data/data2"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mount -t ext4 /dev/nvme3n1 /home/ubuntu/data/data3"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo mount -t ext4 /dev/nvme4n1 /home/ubuntu/data/data4"
ssh -i ~/Desktop/txy.pem ubuntu@$server1PublicIP "sudo chmod 777 /home/ubuntu/data/data1"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo chmod 777 /home/ubuntu/data/data2"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo chmod 777 /home/ubuntu/data/data3"
# ssh -i ~/Desktop/txy.pem ubuntu@$serverPublicIP "sudo chmod 777 /home/ubuntu/data/data4"
# sudo fdisk -l
# sudo df -h
# vim /etc/profile and ~/.bashrc change jdk from 8 to 11
# ssh -i ~/Desktop/txy.pem ubuntu@$server2PublicIP "sudo mkfs -t ext4 /dev/nvme1n1"
# ssh -i ~/Desktop/txy.pem ubuntu@$server2PublicIP "sudo mount -t ext4 /dev/nvme1n1 /home/ubuntu/data/data1"
# ssh -i ~/Desktop/txy.pem ubuntu@$server2PublicIP "sudo chmod 777 /home/ubuntu/data/data1"


# ssh -i ~/Desktop/txy.pem ubuntu@$server1PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$server1PrivateIP server1' >> /etc/hosts && sudo echo '$server2PrivateIP server2' >> /etc/hosts"
# ssh -i ~/Desktop/txy.pem ubuntu@$server2PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$server2PrivateIP server1' >> /etc/hosts && sudo echo '$server1PrivateIP server2' >> /etc/hosts"


#init tpc1
# ssh -i ~/Desktop/txy.pem ubuntu@$tpc1PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$serverPrivateIP server1' >> /etc/hosts"
ssh -i ~/Desktop/txy.pem ubuntu@$tpc1PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$server1PrivateIP server1' >> /etc/hosts && sudo echo '$tpc2PrivateIP tpc2' >> /etc/hosts && sudo echo '$tpc3PrivateIP tpc3' >> /etc/hosts"

#init tpc2 and tpc3
ssh -i ~/Desktop/txy.pem ubuntu@$tpc2PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$server1PrivateIP server1' >> /etc/hosts"
ssh -i ~/Desktop/txy.pem ubuntu@$tpc3PublicIP "sudo chmod 777 /etc/hosts && sudo echo '$server1PrivateIP server1' >> /etc/hosts"


6G 
===============================================
TPCx-IoT Performance Metric (IoTps) Report

Test Run 1 details : Total Time For Warmup Run In Seconds = 21.231
Test Run 1 details : Total Time In Seconds = 21.510
                      Total Number of Records = 3000000
DB_HOST="server1"

TPCx-IoT Performance Metric (IoTps): 139470.0139

===============================================

===============================================
TPCx-IoT Performance Metric (IoTps) Report

Test Run 1 details : Total Time For Warmup Run In Seconds = 25.256
Test Run 1 details : Total Time In Seconds = 25.614
                      Total Number of Records = 3000000

TPCx-IoT Performance Metric (IoTps): 117123.4481

===============================================

20G

===============================================
TPCx-IoT Performance Metric (IoTps) Report

Test Run 1 details : Total Time For Warmup Run In Seconds = 53.549
Test Run 1 details : Total Time In Seconds = 60.004
                      Total Number of Records = 10000000

TPCx-IoT Performance Metric (IoTps): 166655.5562

===============================================

===============================================
TPCx-IoT Performance Metric (IoTps) Report

Test Run 1 details : Total Time For Warmup Run In Seconds = 61.089
Test Run 1 details : Total Time In Seconds = 59.107
                      Total Number of Records = 10000000

TPCx-IoT Performance Metric (IoTps): 169184.6989

===============================================


600G

===============================================
TPCx-IoT Performance Metric (IoTps) Report

Test Run 1 details : Total Time For Warmup Run In Seconds = 225.401
Test Run 1 details : Total Time In Seconds = 207.147
                      Total Number of Records = 300000000

TPCx-IoT Performance Metric (IoTps): 1448246.8971

===============================================

===============================================
TPCx-IoT Performance Metric (IoTps) Report

Test Run 1 details : Total Time For Warmup Run In Seconds = 308.716
Test Run 1 details : Total Time In Seconds = 273.599
                      Total Number of Records = 300000000

TPCx-IoT Performance Metric (IoTps): 1096495.2357



 Raft member(sender) - compete for log manager before commit: 43760840.19, 7626739, 5.74
         Raft member(sender) - commit log in log manager: 236865.61, 7626739, 0.03
           Raft member(sender) - get logs to be committed: 5540.49, 6368968, 0.00
           Raft member(sender) - delete logs exceeding capacity: 115.25, 761, 0.15
           Raft member(sender) - append and stable committed logs: 6295.56, 6368969, 0.00
           Raft member(sender) - apply after committing logs: 201864.49, 6368969, 0.03
             Raft member(sender) - provide log to consumer: 191700.71, 7626716, 0.03
             Raft member(sender) - apply logs that cannot run in parallel: 0.00, 0, NaN
         Raft member(sender) - wait until log is applied: 4677366.20, 7626742, 0.61
           Raft member(sender) - in apply queue: 3944666.84, 7626716, 0.52
           Raft member(sender) - apply data log: 1207017.88, 7626715, 0.16
       Raft member(sender) - log from create to accept: 133048.03, 7626796, 0.02
    Data group member - wait for leader: 0.00, 0, NaN
    Data group member - forward to leader: 0.00, 0, NaN
    Log dispatcher - in queue: 0.00, 0, NaN
    Log dispatcher - from create to end: 0.00, 0, NaN
  Meta group member - execute in remote group: 0.00, 0, NaN
 Raft member(receiver) - index diff: 0.00, 0, NaN





 111
 ===============================================
TPCx-IoT Performance Metric (IoTps) Report

Test Run 1 details : Total Time For Warmup Run In Seconds = 26.115
Test Run 1 details : Total Time In Seconds = 33.594
                      Total Number of Records = 3000000

TPCx-IoT Performance Metric (IoTps): 89301.6610

===============================================
 timer: Meta group member - execute non query: 1439693.01, 231754, 6.21
  Meta group member - execute in local group: 1295069.92, 236214, 5.48
    Data group member - execute locally: 1294867.22, 236214, 5.48
       Raft member(sender) - compete for log manager before append: 259226.36, 236222, 1.10
       Raft member(sender) - locally append log: 199.49, 236222, 0.00
       Raft member(sender) - build SendLogRequest: 3138.47, 236222, 0.01
         Raft member(sender) - build AppendEntryRequest: 1847.74, 236222, 0.01
       Raft member(sender) - offer log to dispatcher: 3696.01, 236222, 0.02
         Raft member(sender) - sender wait for prev log: 0.00, 0, NaN
         Raft member(sender) - serialize logs: 0.00, 0, NaN
         Raft member(sender) - send log: 0.00, 0, NaN
         Raft member(receiver) - log parse: 0.00, 0, NaN
         Raft member(receiver) - receiver wait for prev log: 0.00, 0, NaN
         Raft member(receiver) - append entrys: 0.00, 0, NaN
       Raft member(sender) - wait for votes: 26.62, 236222, 0.00
       Raft member(sender) - locally commit log(using dispatcher): 975457.27, 232720, 4.19
         Raft member(sender) - compete for log manager before commit: 35480.27, 236222, 0.15
         Raft member(sender) - commit log in log manager: 9043.14, 236222, 0.04
           Raft member(sender) - get logs to be committed: 1568.73, 232773, 0.01
           Raft member(sender) - delete logs exceeding capacity: 404.48, 249, 1.62
           Raft member(sender) - append and stable committed logs: 1251.46, 232773, 0.01
           Raft member(sender) - apply after committing logs: 5009.09, 232773, 0.02
             Raft member(sender) - provide log to consumer: 3523.97, 236214, 0.01
             Raft member(sender) - apply logs that cannot run in parallel: 0.00, 0, NaN
         Raft member(sender) - wait until log is applied: 977467.57, 236222, 4.14
           Raft member(sender) - in apply queue: 770526.28, 236214, 3.26
           Raft member(sender) - apply data log: 148966.45, 236214, 0.63
       Raft member(sender) - log from create to accept: 4089.61, 236222, 0.02
    Data group member - wait for leader: 0.00, 0, NaN
    Data group member - forward to leader: 0.00, 0, NaN
    Log dispatcher - in queue: 0.00, 0, NaN
    Log dispatcher - from create to end: 0.00, 0, NaN
  Meta group member - execute in remote group: 0.00, 0, NaN
 Raft member(receiver) - index diff: 0.00, 0, NaN
}

  Meta group member - execute in local group: 1300330.93, 237694, 5.47
    Data group member - execute locally: 1299999.98, 237694, 5.47
       Raft member(sender) - compete for log manager before append: 318709.61, 237702, 1.34
       Raft member(sender) - locally append log: 297.23, 237702, 0.00
       Raft member(sender) - build SendLogRequest: 1699.49, 237702, 0.01
         Raft member(sender) - build AppendEntryRequest: 1385.45, 237702, 0.01
       Raft member(sender) - offer log to dispatcher: 3067.55, 237702, 0.01
         Raft member(sender) - sender wait for prev log: 0.00, 0, NaN
         Raft member(sender) - serialize logs: 0.00, 0, NaN
         Raft member(sender) - send log: 0.00, 0, NaN
         Raft member(receiver) - log parse: 0.00, 0, NaN
         Raft member(receiver) - receiver wait for prev log: 0.00, 0, NaN
         Raft member(receiver) - append entrys: 0.00, 0, NaN
       Raft member(sender) - wait for votes: 30.41, 237702, 0.00
       Raft member(sender) - locally commit log(using dispatcher): 922628.63, 233059, 3.96
         Raft member(sender) - compete for log manager before commit: 53437.56, 237702, 0.22
         Raft member(sender) - commit log in log manager: 8479.88, 237702, 0.04
           Raft member(sender) - get logs to be committed: 1227.92, 233785, 0.01
           Raft member(sender) - delete logs exceeding capacity: 18.70, 243, 0.08
           Raft member(sender) - append and stable committed logs: 1503.08, 233785, 0.01
           Raft member(sender) - apply after committing logs: 5013.34, 233785, 0.02
             Raft member(sender) - provide log to consumer: 3234.72, 237694, 0.01
             Raft member(sender) - apply logs that cannot run in parallel: 0.00, 0, NaN
         Raft member(sender) - wait until log is applied: 901602.78, 237702, 3.79
           Raft member(sender) - put into apply queue for each log: 2448.07, 237694, 0.01
           Raft member(sender) - take from apply queue for each log: 186008.64, 237694, 0.78
           Raft member(sender) - in apply queue: 700158.09, 237694, 2.95
           Raft member(sender) - apply data log: 134613.34, 237694, 0.57
       Raft member(sender) - log from create to accept: 3453.54, 237702, 0.01
    Data group member - wait for leader: 0.00, 0, NaN
    Data group member - forward to leader: 0.00, 0, NaN
    Log dispatcher - in queue: 0.00, 0, NaN
    Log dispatcher - from create to end: 0.00, 0, NaN
  Meta group member - execute in remote group: 0.00, 0, NaN
 Raft member(receiver) - index diff: 0.00, 0, NaN