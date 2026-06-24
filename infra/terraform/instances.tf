# EC2 MySQL
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "db" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.eks_subnet_1.id # <-- AQUÍ ESTÁ EL CAMBIO
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = var.clave_ec2

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl start docker
    systemctl enable docker
    until docker info > /dev/null 2>&1; do sleep 3; done
    docker system prune -af
    docker run -d \
    --name mysql \
    -e MYSQL_ROOT_PASSWORD=${var.password_base_datos} \
    -e MYSQL_DATABASE=${var.nombre_base_datos} \
    -e MYSQL_ROOT_HOST=% \
    -p 3306:3306 \
    --log-opt max-size=10m \
    --log-opt max-file=3 \
    mysql:8-oracle \
    --bind-address=0.0.0.0 \
    --performance-schema=OFF
  EOF

  tags = { Name = "${var.nombre_proyecto}-mysql" }
}