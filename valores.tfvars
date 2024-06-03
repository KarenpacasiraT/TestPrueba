default_region = "us-east-2"
azs = ["us-east-2a", "us-east-2b", "us-east-2c"]
cidr = "10.0.0.0/17"
enable_nat_gateway = true
name = "vpc-prueba"
one_nat_gateway_per_az = false
private_subnet_tags = {
  Role = "private"
}
private_subnets = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
public_subnet_tags = {
  Role = "public"
}
public_subnets = ["10.0.64.0/20", "10.0.80.0/20", "10.0.96.0/20"]
single_nat_gateway = true
tags = {
  Key = "Value"
}