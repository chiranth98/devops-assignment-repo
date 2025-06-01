DevOps Assignment – End-to-End Infrastructure and CI/CD on AWS EKS

This project showcases a complete DevOps workflow designed for a production-ready Python microservices application deployed on a private EKS cluster using Terraform,GitHub Actions, Istio, and ALB.

Project Overview

- Cloud Provider: AWS
- Infrastructure as Code: Terraform
- CI/CD: GitHub Actions
- Orchestration: Kubernetes (EKS)
- Ingress: Istio with AWS ALB
- Secrets Management: AWS IRSA + Kubernetes Secrets
- Backup Strategy: Velero (optional: S3/cron for DB snapshots)
- Monitoring/Logging: [Optional: Prometheus + Grafana, Loki]

---

Project Structure

├── app/                          # Python microservices with Dockerfiles
├── deploy-files/                # Kubernetes YAML files (Deployment, Service, Gateway, etc.)
├── infra/                       # Terraform configuration
│   ├── modules/                 # Reusable Terraform modules (vpc, eks, alb, etc.)
│   ├── envs/
│   │   ├── dev/
│   │   └── prod/
├── .github/workflows/           # GitHub Actions pipelines
├── README.md                    # Project documentation

Key Features

Private EKS Cluster with public ALB for frontend only (Swagger UI)

Multi-stage Docker builds for efficient image layers.

Istio Ingress Gateway integrated with AWS ALB. 

Terraform backend in S3 with remote state and state locking (DynamoDB)

GitHub Actions pipeline to:

Build Docker image

Push to Amazon ECR

Deploy to EKS using kubectl.

Secrets Management using Kubernetes Secrets and AWS IRSA for ECR pull.

Notifications on Slack for failure and success.

Prerequisites

AWS CLI configured with appropriate IAM access

Terraform v1.3+

kubectl and eksctl

Docker (for local image build/testing)

IAM role with ECR, S3, EKS, and EC2 permissions

Access to a bastion/jump host or GitHub self-hosted runner (for private EKS access).

Deployment Steps

1. Clone the Repository
cd devops-assignment

2. Provision Infrastructure

cd terraform/envs/non-prod
terraform init
terraform apply

3. Build & Push Docker Image
Handled via GitHub Actions:

.github/workflows/main.yml

Alternatively:

docker build -t <ecr-uri>:<tag> .
docker push <ecr-uri>:<tag>

4. Deploy Application to EKS

kubectl apply -f deploy-files/

Secrets Management
Using IAM Roles for Service Accounts (IRSA) to pull private images securely from ECR without embedding credentials.

Also supports Kubernetes Secrets for sensitive data (DB credentials, API keys, etc.).

Monitoring & Logging

Grafana and Kiali Dashboard for Metrics and Logs.
