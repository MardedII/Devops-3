# VPC principal
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

# Subred 1 (Zona de disponibilidad A)
resource "aws_subnet" "eks_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region_despliegue}a"
  map_public_ip_on_launch = true
}

# Subred 2 (Zona de disponibilidad B)
resource "aws_subnet" "eks_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.region_despliegue}b"
  map_public_ip_on_launch = true
}

# Internet Gateway para dar salida a internet a la VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Tabla de ruteo pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Asociación de la Subred 1 a la tabla de ruteo
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.eks_subnet_1.id
  route_table_id = aws_route_table.public.id
}

# Asociación de la Subred 2 a la tabla de ruteo
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.eks_subnet_2.id
  route_table_id = aws_route_table.public.id
}