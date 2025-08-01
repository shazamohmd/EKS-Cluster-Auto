# role for nodegroup

resource "aws_iam_role" "node_role" {
  name = "${var.project_name}-node_newrole"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# IAM policy attachment to nodegroup

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_role.name
}

# aws node group 

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.jcluster.name
  node_group_name = "${var.project_name}-private-nodes"
  node_role_arn   = aws_iam_role.node_role.arn

  subnet_ids = [
    var.private_subnet1,
    var.private_subnet2
  ]

  capacity_type  = "${var.capacity_type}"
  instance_types = "${var.instance_type}"
  # ami_type      = "${var.ami_type}"
  disk_size      = "${var.disk_size}"

  scaling_config {
    desired_size = "${var.size}"
    max_size     = "${var.maxsize}"
    min_size     = "${var.minsize}"
  }

  update_config {
    max_unavailable = 1
  }

    tags = {
    Name = "${var.project_name}-node-group"
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

