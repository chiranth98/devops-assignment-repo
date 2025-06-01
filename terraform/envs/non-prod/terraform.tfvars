env             = "non-prod"
tags = {
  Environment = "non-prod"
  Project     = "sample-python-app"
}

clusters = {
  cluster1 = {
    k8s_version         = "1.30"
    node_desired_size   = 3
    node_instance_types = ["t2.small"]
  }
}

name = "non-prod-rds"
