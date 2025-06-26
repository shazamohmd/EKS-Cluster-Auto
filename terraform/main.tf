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
resource "null_resource" "configure_and_test_cluster" {
  provisioner "local-exec" {
    command = <<EOT
      aws eks update-kubeconfig --region ${var.aws_region} --name ${var.project_name}-jcluster
      kubectl get nodes
      echo "connection"
    EOT
  }
    provisioner "local-exec" {
    command = <<EOT
     git clone https://github.com/argoproj/argo-helm.git
     cd argo-helm/charts/argo-cd/
     kubectl create ns myargo
     helm dependency up
     helm install myargo . -f values.yaml -n myargo
     kubectl get po -n myargo
     kubectl port-forward service/myargo-argocd-server 8090:80 -n myargo
     echo "argocd"
     EOT

  }
    provisioner "local-exec" {
    command = "helm install myapp ../hello-world"
  }
    depends_on = [
    module.networks,
    module.eks,
    
  ]
}