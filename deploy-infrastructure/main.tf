module "infrastructure" {
  source = "./modules/infrastructure"
  
  # Input
  region = local.region
  vpc_cidr = local.vpc_cidr
  network_root_name = local.network_root_name
  author = local.author
}

module "role" {
  source = "./modules/role"

  # Input
  region = local.region
  author = local.author
}

module "security" {
  source = "./modules/security"

  # Input
  region = local.region
  author = local.author
  network_root_name = local.network_root_name
  vpc_id = module.infrastructure.vpc_id
}

module "rds" {
  source = "./modules/rds"

  # Input
  region = local.region
  author = local.author
  compute_root_name = local.compute_root_name
  db_username = local.db_username
  db_password = local.db_password
  db_name = local.db_name
  subnet_private1_id = module.infrastructure.subnet_private1_id
  subnet_private2_id = module.infrastructure.subnet_private2_id
  security_group_ids = [ module.security.db_sg_id ]
}

module "compute" {
  source = "./modules/compute"

  # Input
  region = local.region
  key_name = local.key_name
  author = local.author
  compute_root_name = local.compute_root_name
  vpc_id = module.infrastructure.vpc_id
  public_subnet_1_id = module.infrastructure.subnet_public1_id
  public_subnet_2_id = module.infrastructure.subnet_public2_id
  security_group_ids = [ module.security.public_sg_id ]
}

module "others" {
  source = "./modules/others"

  # Input
  region = local.region
  author = local.author
  vpc_id = module.infrastructure.vpc_id
  service_discovery_namespace_name = local.service_discovery_namespace_name
  service_discovery_service_name = local.service_discovery_service_name
}