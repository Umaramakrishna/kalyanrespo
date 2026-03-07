

variable "vpc_cidr" {

    default = "10.80.0.0/16"
  
}

variable "rt_cidr" {

    default = "0.0.0.0/0"

}

variable "subnet_cidr" {

    default = "10.80.1.0/24"
  
}

variable "network_cidr" {

    default = ["10.80.1.55"]
  
}

variable "eip_cidr" {

    default = "10.80.1.55"
  
}

variable "ami" {

    default = "ami-0f3caa1cf4417e51b"
  
}

variable "instance_type" {

    default = "t2.micro"
  
}

variable "key_name" {

    default = "Test"
  
}


variable "instance_env" {

    default = "bath_ser"
  
}
