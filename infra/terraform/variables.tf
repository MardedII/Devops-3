variable "region_despliegue" {
  description = "Región de AWS para el despliegue"
  default     = "us-east-1"
}

variable "nombre_proyecto" {
  description = "Prefijo para los nombres de los recursos"
  default     = "despacho-project"
}

variable "clave_ec2" {
  description = "Nombre del Par de llaves (debe existir en AWS)"
  type        = string
}

variable "password_base_datos" {
  description = "Contraseña para MySQL"
  type        = string
  sensitive   = true
}

variable "nombre_base_datos" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "despachodb"
}