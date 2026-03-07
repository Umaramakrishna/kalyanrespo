
variable "vpc_cidr" {
    default = "10.81.0.0/16"
  
}

variable "rt_cidr" {

    default = "0.0.0.0/0"
  
}

variable "sn_cidr" {

    default = "10.81.3.0/24"
  
}

variable "nic_pvt_ip" {
    default = ["10.81.3.33"]
  
}

variable "eip_pvtip" {

    default = "10.81.3.33"
  
}

variable "ami" {

    default = "ami-02dfbd4ff395f2a1b"
  
}

variable "instance_type" {

    default = "t2.micro"
  
}

variable "key_name" {
    default = "Kalyankey"
  
}

variable "instance_env" {

    default = "kalyan_instance"
  
}