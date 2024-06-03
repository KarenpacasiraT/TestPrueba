# main.tf

provider "aws" {
  region     = var.default_region
  access_key = "AKIA6GBMHGXU6TIABQN6"
  secret_key = "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"
}

# Crear la VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = {
    Name = var.name
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# Crear subredes públicas
resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.name}-public-subnet-${count.index}"
    Role = "public"
  }
}

# Crear subredes privadas
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.name}-private-subnet-${count.index}"
    Role = "private"
  }
}


# outputs.tf

output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

# variables.tf

variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "default_region" {
  type        = string
  description = "La región por defecto para el proveedor AWS"
}
