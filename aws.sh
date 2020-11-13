// create instances
aws ec2 run-instances \
--image-id ami-0c32401bd37a3a5e5 \
--instance-type t2.micro \
--count 1 \
--key-name txy \
--security-group-ids sg-c42e09ba \
--subnet-id subnet-14631a58 \
--tag-specifications 'ResourceType=instance,Tags=[{Key=tpc,Value=tpc}]' \
--network-interfaces 'AssociatePublicIpAddress=true,DeviceIndex=0'


// get all ips
export ips=`aws ec2 describe-instances --filters "Name=tag:tpc,Values=tpc" --query "Reservations[].Instances[].NetworkInterfaces[].Association[].PublicIp"`
echo $ips


// terminate all instances
export instanceIds=`aws ec2 describe-instances --filters "Name=tag:tpc,Values=tpc" --query "Reservations[].Instances[].InstanceId"`
aws ec2 terminate-instances --instance-ids $instanceIds