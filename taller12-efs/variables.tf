#Region donde se desplegará los recursos de AWS
variable "region" {
  description = "The AWS region"
  type = string
  default = "us-east-1"
}

variable "ami_id" {
  description = "ID de la AMI"
  type = string
  default = "ami-0c230065b91270bc6"
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type = string
  default = "t2.micro"
}

variable "nombre_llaves" {
  description = "Nombre de la llave para acceder a la instancia"
  type = string
  default = "mi-primera-llaves-as"
}

variable "cantidad_instancias" {
    description = "Cantidad de instancias a crear"
    type = number
    default = 2
}