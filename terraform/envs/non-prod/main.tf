module "s3_backend" {
  source           = "../../modules/s3-backend"
  bucket_name      = "dev-assign-tfstate"
  lock_table_name  = "dev-assign-locks"
  tags = {
    Environment = "non-prod"
    Project     = "DevOps Assignment"
  }
}


module "vpc" {
  source        = "../../modules/vpc"
  name          = "devops"
  aws_region    = "ap-south-1"
  vpc_cidr      = "10.0.0.0/16"

  azs = {
    a = "ap-south-1a"
    b = "ap-south-1b"
  }

  public_subnets = {
    a = { cidr = "10.0.1.0/24", az = "ap-south-1a" }
    b = { cidr = "10.0.2.0/24", az = "ap-south-1b" }
  }

  private_subnets = {
    a = { cidr = "10.0.101.0/24", az = "ap-south-1a" }
    b = { cidr = "10.0.102.0/24", az = "ap-south-1b" }
  }

  tags = {
    Environment = "non-prod"
    Project     = "DevOps Assignment"
  }
}

module "eks" {
  source   = "../../modules/eks"
  for_each = var.clusters

  cluster_name        = each.key
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  k8s_version         = each.value.k8s_version
  node_desired_size   = each.value.node_desired_size
  node_instance_types = each.value.node_instance_types
  tags                = merge(var.tags, { Environment = "non-prod" })
}


# module "rds" {
#   source = "../../modules/rds"

#   rds_instances = var.rds_instances
#   vpc_id        = module.vpc.vpc_id
#   tags          = merge(var.tags, { Environment = "non-prod" })
# }


module "rds" {
  source                = "../../modules/rds"
  name                  = var.name
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  eks_security_group_id = module.eks["cluster1"].eks_security_group_id
  tags                  = var.tags

  databases = {
    postgres1 = {
      username = "DevopsUser"
      password = "MyStr0ngPassw0rd!"
    }
  }
}
