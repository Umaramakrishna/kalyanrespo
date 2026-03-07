




resource "aws_vpc" "prod_vpc" { 

    cidr_block = var.vpc_cidr

    tags = {

        Name = "prod_vpc"
    }

  
}


resource "aws_internet_gateway" "prod_igw" {

    vpc_id = aws_vpc.prod_vpc.id

    tags = {
      Name = "prod_igw"
    }
  
}

resource "aws_route_table" "prod_rt" {

    vpc_id = aws_vpc.prod_vpc.id

    route {

        cidr_block = var.rt_cidr
        gateway_id = aws_internet_gateway.prod_igw.id
    }
  tags = {
    Name = "prod_rt"
  }
}

resource "aws_subnet" "prod_sn" {
  
  vpc_id = aws_vpc.prod_vpc.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "prod_sn"
  }

}

resource "aws_route_table_association" "prod_rt_asso" {

  route_table_id = aws_route_table.prod_rt.id
  subnet_id = aws_subnet.prod_sn.id
  
}


resource "aws_security_group" "prod_sg" {

name = "prod_web_sg"
description = "allow SSH,HTTP and HTTPS protocols"
vpc_id = aws_vpc.prod_vpc.id
  
  ingress {
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]

  }


  ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
   from_port = 443
   to_port = 443
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
   from_port = 0
   to_port = 0
   protocol = -1
   cidr_blocks = ["0.0.0.0/0"]

  }
tags = { 

  Name = "prod_sg"
}

}

resource "aws_network_interface" "prod_nic" {

subnet_id = aws_subnet.prod_sn.id
security_groups = [aws_security_group.prod_sg.id]
private_ips = var.network_cidr

tags = {
  Name = "prod_nic"
}
  
}

resource "aws_eip" "prod_eip" {
  domain = "vpc"
  network_interface = aws_network_interface.prod_nic.id
  associate_with_private_ip = var.eip_cidr

  tags = {
    Name = "prod_eip"  
 
  }
  

}

resource "aws_instance" "prod_instance" {

  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = file("sample.sh")

  network_interface {

    network_interface_id = aws_network_interface.prod_nic.id
    device_index = 0
  }

  tags = {
    Name = var.instance_env
  }
  
}

   
  

