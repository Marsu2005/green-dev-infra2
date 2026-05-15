# GreenDevCorp Infrastructure

Infraestructura containeritzada i orquestrada per a GreenDevCorp. Inclou Nginx, una aplicació backend en Python i una base de dades PostgreSQL desplegades a Kubernetes mitjançant Terraform.

## Documentació

La documentació completa del projecte es troba dins del repositori GitHub

## Requisits previs

- Docker instal·lat i en execució
- Minikube instal·lat
- Terraform instal·lat
- `kubectl` instal·lat

## Desplegament ràpid

```bash
git clone https://github.com/Marsu2005/green-dev-infra2
cd green-dev-infra2

minikube start --driver=docker

cd terraform
terraform init
terraform apply
