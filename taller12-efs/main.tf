#configuracion del provedor de AWS
provider "aws" {
  region = var.region
}

#creamos el security group efs
resource "aws_security_group" "mi_sg_efs" {
    name = "mi-security-group-efs" #nombre del security group
    description = "Security group para mi instancia de Terraform con efs" #descripcion del security group
    vpc_id = "vpc-00f3772a96712e32c" 
    #reglas de entrada para SSH
    ingress {
        from_port = 22 #puerto de entrada para SSH
        to_port = 22 #puerto de salida para SSH
        protocol = "tcp" #protocolo TCP
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 2049 #puerto de entrada para SSH
        to_port = 2049 #puerto de salida para SSH
        protocol = "tcp" #protocolo TCP
        cidr_blocks = ["0.0.0.0/0"]
    }

    #reglas de salida para HTTP
    egress {
        from_port = 0 #puerto de entrada para HTTP
        to_port = 0 #puerto de salida para HTTP
        protocol = "-1" #protocolo TCP
        cidr_blocks = ["0.0.0.0/0"]
    }

}


#creamos el security group
resource "aws_security_group" "mi_sg_efs_instancias" {
    name = "mi-security-group-instancias" #nombre del security group
    description = "Security group para mi instancia de Terraform para instancia con efs" #descripcion del security group
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
        from_port = 2049 #puerto de entrada para HTTP
        to_port = 2049 #puerto de salida para HTTP
        protocol = "tcp" #protocolo TCP
        cidr_blocks = ["0.0.0.0/0"]
    }

}

#declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_efs" {
    ami = var.ami_id #id de la imagen de la instancia
    instance_type = var.tipo_instancia #tipo de instancia
    key_name = var.nombre_llaves #nombre de la clave para acceder a la instancia
    count = var.cantidad_instancias #cantidad de instancias a crear
    tags = {
        Name = "Mi Instancia EFS - ${count.index + 1}" #etiqueta para identificar la instancia
    }
    vpc_security_group_ids = [aws_security_group_instancias.mi_sg_efs_instancias.id] #asignamos el security group a la instancia
    
}

