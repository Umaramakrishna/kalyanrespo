


resource "aws_vpc" "kal_vpc" {
    
    cidr_block = var.vpc_cidr

    tags = {

        Name = "kal_vpc"
    }
  
}

resource "aws_internet_gateway" "kal_igw" {
    vpc_id = aws_vpc.kal_vpc.id

    tags = {

        Name = "kal_igw" 
    }
  
}

resource "aws_route_table" "kal_rt" {
    vpc_id = aws_vpc.kal_vpc.id

    route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.kal_igw.id
    }

    tags = {

        Name = "kal_rt"
    }

}

resource "aws_subnet" "kal_sn" {
    vpc_id = aws_vpc.kal_vpc.id
     
     cidr_block = var.sn_cidr

     tags = {
       Name = "kal_sn"
     }

  
}

resource "aws_route_table_association" "kal_rt_asso" {
    route_table_id = aws_route_table.kal_rt.id
    subnet_id = aws_subnet.kal_sn.id
}

resource "aws_security_group" "kal_sg" {
    name = "web_sg"
    description = "allow 443,22 and 80 protocols"
    vpc_id = aws_vpc.kal_vpc.id

    ingress {

        from_port = 443
        to_port = 443
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

        from_port = 80
        to_port = 80
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
      Name = "kal_sg"
    }
      
  
}

resource "aws_network_interface" "kal_nic" {
    subnet_id = aws_subnet.kal_sn.id
    security_groups = [aws_security_group.kal_sg.id]
    private_ips = var.nic_pvt_ip

    tags = {
      Name = "kal_nic"
    }
  
}

resource "aws_eip" "kal_eip" {
    domain = "vpc"
    network_interface = aws_network_interface.kal_nic.id
    associate_with_private_ip = var.eip_pvtip

    tags = {
        Name = "kal_eip"
    }
  
}

resource "aws_instance" "kal_instance" {

    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    user_data = file("sample.sh")

    network_interface {
      network_interface_id = aws_network_interface.kal_nic.id
      device_index = 0
    }
     
    tags = {
        Name = var.instance_env
    }


}


