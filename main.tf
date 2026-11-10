#configuracion del provedor de AWS
provider "aws" {
  region = "us-east-1" 
}

#creamos el security group
resource "aws_security_group" "mi_sg_as" {
    name = "mi-security-group_as" 
    description = "Security group para mi instancia de Terraform con Windows" 
    vpc_id = "vpc-00f3772a96712e32c" 
    #reglas de entrada para SSH
    ingress {
        from_port = 3389
        to_port = 3389
        protocol = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80 
        to_port = 80
        protocol = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
    }

    #reglas de salida para HTTP
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" 
        cidr_blocks = ["0.0.0.0/0"]
    }

}
#declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_2" {
    ami = "ami-0b5f645abc199e666" 
    instance_type = "t3.micro" 
    key_name = "mi-primera-llaves-as" 
    tags = {
        Name = "MiInstanciaTerraform-Windows-as" 

    }
    vpc_security_group_ids = [aws_security_group.mi_sg_as.id] 
}