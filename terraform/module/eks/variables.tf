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

#variable "ami_type" {
 # description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
 # type        = string
 # default     = "AL2_x86_64"
#}

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
variable "private_subnet1" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet2" {
  description = "ID of the second private subnet"
  type        = string
}

variable "public_subnet1" {
  description = "ID of the first public subnet"
  type        = string
}

variable "public_subnet2" {
  description = "ID of the second public subnet"
  type        = string
}