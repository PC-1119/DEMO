variable "Access_Key"{
type = string
}
variable "Secret_Key"{
type = string
}
variable "ami"{
default = "ami-010aff33ed5991201"
}
variable "instance_type"{
type    = string
default = "t2.micro"
}
variable "cidr_block"{
default = "10.0.0.0/16"
}