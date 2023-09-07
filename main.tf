terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.AWS_REGION
  # export AWS_ACCESS_KEY_ID="anaccesskey"
  # export AWS_SECRET_ACCESS_KEY="asecretkey"
  # export AWS_REGION="us-west-2"
}

# bootstrap VPC, subnets, IGW
module "network" {
  source = "./modules/network"

}

# bootstrap IAM roles
module "iam" {
  source = "./modules/iam"
}


# Shangrila EKS Cluster and Nodes
resource "aws_eks_cluster" "shangrila-eks-cluster" {
  name     = "shangrila-eks-cluster"
  role_arn = module.iam.eks_iam_role_arn

  vpc_config {
    subnet_ids = [module.network.primary_subnet_id, module.network.secondary_subnet_id]
  }

  depends_on = [
    module.network.primary_subnet_id,
    module.network.secondary_subnet_id,
    module.iam.eks_iam_role_arn,
  ]
}

resource "aws_eks_node_group" "shangrila-eks-node-group" {
  cluster_name    = aws_eks_cluster.shangrila-eks-cluster.name
  node_group_name = "shangrila-workernodes"
  node_role_arn   = module.iam.eks_worker_iam_role_arn
  subnet_ids      = [module.network.primary_subnet_id, module.network.secondary_subnet_id]
  instance_types  = ["t3.large"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    module.network.primary_subnet_id,
    module.network.secondary_subnet_id,
    module.iam.eks_worker_iam_role_arn
  ]
}

