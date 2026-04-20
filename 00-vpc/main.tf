module "vpc" {
  source =  "git::https://github.com/sammusku/terraform-aws-vpc.git?ref=main"
  project = var.project
  environment = var.environment
  is_peering_required = true
}