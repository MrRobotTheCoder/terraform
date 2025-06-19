# Locals can be used to define large and complex codes in shorter terms. example: locals.instance_id
# A set of related local values can be declared together in a single locals block; inclusing variables, resource attributes or other local values. 

locals {
  owners = var.business_division
  environment = var.environment
  name = "${var.business_division}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
}