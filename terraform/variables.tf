variable "app_port" {
  description = "Port where the backend application listens"
  type        = string
  default     = "8000"
}

variable "backend_image" {
  description = "Backend Docker image"
  type        = string
  default     = "marcalfigueras/simple-app-gsx:v4"
}

variable "backend_replicas" {
  description = "Number of backend replicas"
  type        = number
  default     = 1
}

variable "nginx_image" {
  description = "Nginx Docker image"
  type        = string
  default     = "marcalfigueras/nginx-gsx:v4"
}

variable "nginx_replicas" {
  description = "Number of nginx replicas"
  type        = number
  default     = 1
}

variable "nginx_node_port" {
  description = "NodePort used to expose Nginx"
  type        = number
  default     = 30080
}

variable "db_host" {
  description = "Kubernetes service name for PostgreSQL"
  type        = string
  default     = "db"
}

variable "db_port" {
  description = "PostgreSQL port"
  type        = string
  default     = "5432"
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
  default     = "testdb"
}

variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
  default     = "user"
}

variable "db_image" {
  description = "PostgreSQL Docker image"
  type        = string
  default     = "postgres:16-alpine"
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  default     = "password"
}
