# teste-dreamsquad-diogolpievan

# DreamSquad Technical Test — Terraform Infrastructure

Este projeto implementa três serviços na AWS utilizando Terraform, atendendo ao desafio técnico:

1. **Service 1 — Frontend**  
   Aplicação estática hospedada em **Amazon S3** como _static website hosting_.

2. **Service 2 — Backend**  
   API Node.js (Express) containerizada e executada em **EC2** com Docker.

3. **Service 3 — Job Lambda**  
   Função AWS Lambda (Python) executada diariamente via **Amazon EventBridge**, que cria um arquivo `.txt` no S3 contendo a data/hora da execução.

---

## 📂 Estrutura de Pastas

```
.
├── service1-frontend/      # S3 Static Website
├── service2-backend/       # EC2 com backend Node.js em container
├── service3-job/           # Lambda + EventBridge + S3
└── provider.tf             # Configuração global do provider AWS
```
---

## 🚀 Pré-requisitos

- **AWS CLI** configurado (`aws configure`)
- **Terraform** v1.5+ instalado
- Conta AWS com permissões para:
  - S3, EC2, Lambda, EventBridge, IAM

---

## ⚙️ Configuração

1. **Clonar este repositório**
   ```
   git clone https://github.com/seuusuario/dreamsquad-test.git
   cd dreamsquad-test

    Configurar variáveis
    Ajuste as variáveis necessárias nos arquivos variables.tf ou via terraform.tfvars:
    hcl

    aws_region     = "us-east-1"
    run_hour_utc   = "13"   # Equivalente a 10h BRT
    run_minute_utc = "00"

📦 Deploy

    Inicializar o Terraform

    terraform init

Aplicar a infraestrutura

    terraform apply

    Confirme com yes.

📌 Serviços
Service 1 — Frontend

    Hospedado no Amazon S3 (static website).

    Deploy automático via Terraform.

Output:

frontend_url = "http://<bucket-name>.s3-website-<region>.amazonaws.com"

Service 2 — Backend

    API Node.js rodando em container Docker na EC2.

    Imagem pública do Docker Hub (diogolpievan/test-dreamsquad-backend).

    Porta 80 exposta.

Testes:
```
curl http://<ec2-public-ip>/
curl http://<ec2-public-ip>/greet/:name
curl -X POST http://<ec2-public-ip>/data \
-H "Content-Type: application/json" \
-d '{"name": "Alfredo"}'
```
Service 3 — Job Lambda

    Função Python executada diariamente às 10h BRT (13h UTC).

    Cria arquivo timestamp.txt no S3 a cada execução.

Testar manualmente:

aws lambda invoke \
  --function-name service3-job-function \
  --payload '{}' \
  response.json
cat response.json

🗑 Remover Infraestrutura

Para destruir todos os recursos:


terraform destroy

📝 Observações

    Nomes de buckets S3 incluem sufixos aleatórios para evitar conflitos globais.

    Imagem Docker do backend já está publicada no Docker Hub para facilitar o deploy.

    Permissões IAM configuradas com princípio de menor privilégio (Lambda/EC2).

    Custos: Recursos utilizam free-tier onde possível.
