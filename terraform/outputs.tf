output "nginx_service" {
  value = "http://localhost:30080"
}

output "backend_service" {
  value = "http://backend:8000"
}

output "database_service" {
  value = "db:5432"
}
