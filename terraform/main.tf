module "networks" {
  source = "./module/networks"

  project_name   = var.project_name
  vpc_cidr       = var.vpc_cidr
  aws_region     = var.aws_region
  subnet1_cidr    = var.subnet1_cidr
  subnet2_cidr    = var.subnet2_cidr
  subnet3_cidr    = var.subnet3_cidr
  subnet4_cidr    = var.subnet4_cidr
}

module "eks" {
  source = "./module/eks"
  project_name   = var.project_name
  capacity_type  = var.capacity_type
  instance_type = var.instance_type
  #ami_type      = var.ami_type
  disk_size      = var.disk_size
  size = var.size
  maxsize     = var.maxsize
  minsize     = var.minsize
  private_subnet1 = module.networks.private1
  private_subnet2 = module.networks.private2
  public_subnet1  = module.networks.public1
  public_subnet2  = module.networks.public2




}