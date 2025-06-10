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
variable "project_name" {
  description = "Name of the project"
  type        = string
}