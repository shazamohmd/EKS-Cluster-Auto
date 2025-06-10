variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT"
  type        = string
}

variable "instance_type" {
  description = "List of instance types associated with the EKS Node Group"
  type        = list(string)

}

# variable "ami_type" {
#   description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
#   type        = string
  
# }

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number

}

variable "size" {
  description = "Desired number of worker nodes"
  type        = number
 
}

variable "maxsize" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "minsize" {
  description = "Minimum number of worker nodes"
  type        = number
 
}
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}
variable "vpc_cidr" {
  description = "The VPC range"
  type        = string
}

variable "subnet1_cidr" {
  description = "The subnet range"
  type        = string
}
variable "subnet2_cidr" {
  description = "The subnet range"
  type        = string
}
variable "subnet3_cidr" {
  description = "The subnet range"
  type        = string
}
variable "subnet4_cidr" {
  description = "The subnet range"
  type        = string
}
