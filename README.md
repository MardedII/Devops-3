# Despachos y Ventas App

Aplicación para consulta de despachos y ventas.  
Monorepo que contiene el frontend, dos backends (despachos y ventas) y la infraestructura como código.

## Requisitos previos

- **Java 17**
- **Maven/Gradle**
- **Node.js**
- **Docker** y **Docker Compose**
- **Terraform**
  
## Guía de Comandos Utilizados

### Terraform (Infraestructura como Código)
*Comandos ejecutados dentro del directorio infra/terraform/*

```bash
# Inicializar el entorno descargando los proveedores de AWS
terraform init

# Previsualizar los recursos que se van a crear en AWS
terraform plan

# Desplegar el clúster de EKS, la VPC y el grupo de nodos con el LabRole
terraform apply

# Configurar las llaves de acceso temporales de AWS Academy
aws configure

# Actualizar el contexto de red kubeconfig para conectarse al clúster de EKS
aws eks update-kubeconfig --region us-east-1 --name despacho-cluster

# Desplegar todos los microservicios y bases de datos en el clúster
kubectl apply -f infra/k8s/

# Verificar el estado de salud de todos los Pods (Running)
kubectl get pods

# Obtener las URLs de acceso público generadas por el Load Balancer
kubectl get svc

# Revisar los registros internos de un contenedor para detectar fallos
kubectl logs <nombre_del_pod>

# Limpiar y eliminar todos los recursos despliega-dos en el clúster
kubectl delete -f infra/k8s/

# Revisar qué archivos han sido modificados localmente
git status

# Preparar todos los cambios para el envío
git add .

# Registrar los cambios en el historial con un mensaje informativo
git commit -m "----"

# Subir los cambios a la rama develop para disparar el pipeline automático
git push origin develop
