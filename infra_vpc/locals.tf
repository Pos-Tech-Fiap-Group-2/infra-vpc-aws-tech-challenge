locals {

  common_tags = {
    "Project" = "VPC Tech-Challenge"
    CreatedAt = timestamp()
    ManagedBy = "Terraform"
    Owner     = "VPC Tech-Challenge"
  }
}