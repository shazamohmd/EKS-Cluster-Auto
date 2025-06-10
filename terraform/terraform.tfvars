aws_region = "us-east-1"

vpc_cidr = "192.168.0.0/16"

subnet1_cidr = "192.168.10.0/24"
subnet2_cidr = "192.168.20.0/24"
subnet3_cidr = "192.168.30.0/24"
subnet4_cidr = "192.168.40.0/24"

project_name = "eks-cluster"

capacity_type = "ON_DEMAND"
instance_type = ["t3.medium"] 
disk_size = "20"
size = "2"
maxsize = "4"
minsize ="0"