#configuracion del provedor de AWS
provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos
}

#creamos el security group
resource "aws_security_group" "mi_sg" {
    name = "mi-security-group" #nombre del security group
    description = "Security group para mi instancia de Terraform" #descripcion del security group
    vpc_id = "vpc-00f3772a96712e32c" 
    #reglas de entrada para SSH
    ingress {
        from_port = 22 #puerto de entrada para SSH
        to_port = 22 #puerto de salida para SSH
        protocol = "tcp" #protocolo TCP
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80 #puerto de entrada para SSH
        to_port = 80 #puerto de salida para SSH
        protocol = "tcp" #protocolo TCP
        cidr_blocks = ["0.0.0.0/0"]
    }

    #reglas de salida para HTTP
    egress {
        from_port = 80 #puerto de entrada para HTTP
        to_port = 80 #puerto de salida para HTTP
        protocol = "tcp" #protocolo TCP
        cidr_blocks = ["0.0.0.0/0"]
    }

}
#declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_2" {
    ami = "ami-0c230065b91270bc6" #id de la imagen de la instancia
    instance_type = "t2.micro" #tipo de instancia
    key_name = "mi-primera-llaves-as" #nombre de la clave para acceder a la instancia
    tags = {
        Name = "MiInstanciaTerraform2" #etiqueta para identificar la instancia

    }
    vpc_security_group_ids = [aws_security_group.mi_sg.id] #asignamos el security group a la instancia
}