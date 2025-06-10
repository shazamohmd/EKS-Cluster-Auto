resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}-vpc"
  }
}
# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}
# Create public subnets
resource "aws_subnet" "public" {
  for_each = {
    "public_subnet1" = {
      cidr_block        = var.subnet1_cidr
      availability_zone = "${var.aws_region}a"
    }
    "public_subnet2" = {
      cidr_block        = var.subnet2_cidr
      availability_zone = "${var.aws_region}b"
    }
  }

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block             = each.value.cidr_block
  availability_zone      = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
    Type = "Public"
    "kubernetes.io/role/elb"     = "1"

  }
}
output "public1" {
  value       = aws_subnet.public["public_subnet1"].id
  description = "The ID of the public subnet"
}

output "public2" {
  value       = aws_subnet.public["public_subnet2"].id
  description = "The ID of the public subnet"
}

# private subnets
resource "aws_subnet" "private" {
  for_each = {
    "private_subnet1" = {
      cidr_block        = var.subnet3_cidr
      availability_zone = "${var.aws_region}a"
    }
    "private_subnet2" = {
      cidr_block        = var.subnet4_cidr
      availability_zone = "${var.aws_region}b"
    }
  }

  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.key
    Type = "Private"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
output "private1" {
  value       = aws_subnet.private["private_subnet1"].id
  description = "The ID of the private subnet"
}

output "private2" {
  value       = aws_subnet.private["private_subnet2"].id
  description = "The ID of the private subnet"
}

# Create Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

# Create a single NAT Gateway in the first public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public["public_subnet1"].id  # Place it in the first public subnet

  tags = {
    Name = "${var.project_name}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Create Route Table
resource "aws_route_table" "public_routing" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public_routing"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public["public_subnet1"].id
  route_table_id = aws_route_table.public_routing.id
} 
resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public["public_subnet2"].id
  route_table_id = aws_route_table.public_routing.id
} 

resource "aws_route_table" "private_routing" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat.id 
    }

  tags = {
    Name = "${var.project_name}-private_routing"
  }
}
resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private["private_subnet1"].id
  route_table_id = aws_route_table.private_routing.id
} 
resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private["private_subnet2"].id
  route_table_id = aws_route_table.private_routing.id
} 