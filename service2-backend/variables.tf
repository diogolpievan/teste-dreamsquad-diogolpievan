variable "ami_id" {
    description = "ID da imagem para EC2"
    type = string
    default = "ami-0a0e5d9c7acc336f1"
}
variable "instance_type" {
    description = "Tipo da Instância da EC2"
    type = string
    default = "t2.micro"
}
