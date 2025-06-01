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


____________________________________________________________

Security Considerations
IAM Roles for Service Accounts (IRSA): Securely grants EKS pods fine-grained access to AWS services like ECR and S3 without using long-lived credentials.

Private Subnets + NAT Gateway: Worker nodes and system services are deployed in private subnets with no direct internet access.

ALB + Security Groups: Ingress traffic is filtered through ALB security groups, and backend services are locked down with tight security group rules.

Kubernetes Secrets: Application secrets are stored securely using Kubernetes Secrets with RBAC controlling access to them.

EKS Nodegroup IAM Role Restrictions: Limited access using least-privilege policies (only granting permissions required for pulling images or managing volumes).

Use of VPC Endpoints for the Internal Communication for the Services ( ECR, STS, S3).

_____________________________________________________________________________________

Cost Optimization Measures
Spot Instances (Optional Enhancement): Architecture supports addition of spot node groups for non-critical or batch workloads using karpenter.

Terraform for_each & Modules: Encourages infrastructure reuse, reducing maintenance costs and promoting DRY principles.

ALB Target Group Reuse: Istio Gateway configured to reduce redundant ALB provisioning (single ALB for multiple routes/apps).

S3 Lifecycle Policies: For Terraform state and backups, lifecycle rules can move older versions to infrequent access or archive tiers.

CloudWatch Log Retention: Log groups are configured with limited retention to avoid unnecessary log storage costs.

Right-Sized Instances: EKS node group instance types selected based on workload requirements, avoiding over-provisioning.




