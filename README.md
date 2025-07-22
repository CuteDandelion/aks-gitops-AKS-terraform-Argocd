## Overview

This project sets up a cloud-native **Kanban board app** on a Production-grade **Kubernetes cluster** running on **Azure Kubernetes Service (AKS)**. It uses **Terraform** to handle the entire infrastructure on **Azure**, and **GitHub Actions** powers a reliable **CI/CD pipeline**. An **Azure Container Registry (ACR)** is created for managing **Docker images**, and the **NGINX Ingress Controller** is used to manage global traffic securely and efficiently—including **HTTPS** support. The setup is designed for scalability, security, and smooth performance. It includes **Cert-Manager** for automatic **SSL certificates**, **ExternalDNS** for real-time DNS updates, **Helm** for managing **Kubernetes packages**, **ArgoCD** for **GitOps-based** deployment, and **Prometheus** & **Grafana** for full-stack monitoring and visibility.

## End-to-End Architecture Diagram
<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/architecture.png?raw=true" width="1000">

---

## 🎥Live Demonstration

<div style="text-align: center; margin: 20px 0;">
  <h3>Prod:</h3>
  <div style="width: 200px; margin: 0 auto; border-radius: 10px;overflow: hidden; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/kanbanapp.gif?raw=true" alt="Live App GIF" width="60%" />
  </div>
</div>

--- 

##  Running the Kanban Board App Locally

If you'd like to develop or test the Kanban board application on your local machine, follow these steps:

1. Navigate to the `app` directory:
   ```bash
   cd app
    ```

2. **Install the dependencies:**
   ```bash
   npm install
   ```
3. **Start the development server:**
   ```bash
   npm run dev
   ```

4. Open your browser and go to `http://localhost:3000` (or the port shown in your terminal) to view the app.


##  Key Components

| Component                     | Description                                                                                          |
| :---------------------------- | :--------------------------------------------------------------------------------------------------- |
| Azure Kubernetes Service (AKS) | Hosts the production-grade Kubernetes cluster that runs the Kanban board application.                |
| Azure Container Registry (ACR) | Stores and manages Docker images securely, used by the AKS cluster for application deployments.      |
| GitHub Actions (CI/CD)        | Automates testing, building, security scanning, and deployment of infrastructure and application code. |
| Terraform                     | Manages and provisions all infrastructure components using Infrastructure as Code (IaC) practices.   |
| Helm                          | Kubernetes package manager used to install and manage applications like ArgoCD, Prometheus, and NGINX Ingress. |
| ArgoCD                        | Implements GitOps to continuously synchronize Kubernetes manifests from the Git repository to AKS.   |
| NGINX Ingress Controller      | Manages HTTP/HTTPS traffic routing inside the cluster and supports SSL termination.                  |
| Cert-Manager                  | Automatically issues and renews SSL certificates using Let's Encrypt for secure HTTPS access.         |
| ExternalDNS                   | Updates Azure DNS records dynamically based on Kubernetes Ingress resources.                         |
| Prometheus                    | Collects and stores metrics for the cluster, application, and infrastructure monitoring.              |
| Grafana                       | Visualizes metrics from Prometheus and provides dashboards for real-time observability.               |
| Trivy                         | Performs container image vulnerability scanning as part of the CI workflow.                          |
| TFLint                        | Enforces Terraform best practices and catches syntax issues during infrastructure validation.         |
| Checkov                       | Scans Terraform code for misconfigurations and compliance issues in infrastructure definitions.       |

## Project Structure

```
aks-gitops-kanban/
│
├── .github/
│ └── workflows/ 
│ ├── docker-build.yml 
│ ├── tf-apply.yml # Applies Terraform infrastructure changes
│ ├── tf-destroy.yml # Destroys Terraform-managed infrastructure
│ └── tf-plan.yml # Terraform plan, lint, and security checks
│
├── app/ 
│ ├── Dockerfile 
│ ├── .dockerignore 
│ └── ... # Public, src, package.json, etc.
│
├── docs/ # Documentation assets (e.g., images, diagrams)
│
├── k8s-manifests/ 
│ ├── argocd/ 
│ ├── cert-manager/ 
│ ├── ingress/ 
│ ├── kanban-app/ 
│ └── monitoring/ 
│
├── terraform/ # Root Terraform configurations
│ ├── backend.tf
│ ├── kubernetes.tf
│ ├── main.tf
│ ├── provider.tf
│ ├── variables.tf
│ └── modules/ # Reusable infrastructure modules
│ ├── acr/
│ ├── aks/
│ ├── dns/
│ ├── identity/
│ ├── network/
│ ├── role_assignment/
│ └── storage/
│
├── .gitignore 
├── README.md 
```

##  Deployment to Azure

This project automates the deployment of the Kanban board application to Azure using a modern GitOps-driven workflow built on AKS, Terraform, and GitHub Actions. The deployment process includes the following stages:

1. **Dockerisation:**
   
   The application is containerised using the `Dockerfile` located in the `app/` directory. This ensures consistency across development, staging, and production environments.

3. **Building and Pushing the Docker Image:**
    
   When code changes are pushed to the `main` branch, the `docker-build.yml` GitHub Actions workflow is triggered. It builds the Docker image, runs a **Trivy** vulnerability scan, and pushes the image to **Azure Container Registry (ACR)**.

5. **Infrastructure Validation (on Pull Request):**
   
   When a Pull Request modifies Terraform code, the `tf-plan.yml` workflow runs automatically. It executes:
   - `terraform plan` to preview infrastructure changes  
   - `tflint` to ensure Terraform syntax and standards  
   - `checkov` to scan for security and compliance issues  

7. **Infrastructure Provisioning (on Merge):**
   
   Once approved and merged, the `tf-apply.yml` workflow provisions or updates infrastructure on Azure using **Terraform**, including ACR, AKS, identity, networking, and DNS.

9. **GitOps Deployment via ArgoCD:**
    
   **ArgoCD** continuously watches the Git repository (under `k8s-manifests/`) and automatically syncs Kubernetes manifests to the AKS cluster. This ensures that the live environment always reflects the desired state stored in Git.

11. **Ingress, SSL, and DNS Setup:**
      
   - **NGINX Ingress Controller** handles HTTPS routing within the AKS cluster.  
   - **Cert-Manager** automatically issues and renews SSL certificates via Let's Encrypt.  
   - **ExternalDNS** syncs Kubernetes ingress records with **Azure DNS**, enabling real-time domain mapping.

11. **Monitoring and Observability:**
    
   **Prometheus** collects metrics from the cluster and workloads. **Grafana** dashboards provide real-time insights into application and infrastructure health.


## 📸 Kanban Board App: Live on Azure with GitOps, Monitoring, and CI/CD

### ✅ ArgoCD: GitOps Deployment to AKS

Kanban App is continuously deployed to AKS using ArgoCD. All Kubernetes manifests are stored in Git (`k8s-manifests/`), and ArgoCD keeps the AKS cluster in sync with the Git source of truth.

<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/argocd.png?raw=true">
<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/argocdsync.png?raw=true">

---

### ✅ Prometheus & Grafana: Full-Stack Observability

**Prometheus** scrapes metrics from the AKS cluster, workloads, and system components. **Grafana** provides real-time dashboards and alerting for system health, resource usage, and more.

**Prometheus Targets View:**

<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/prometheus.png?raw=true">

**Grafana Login:**

<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/grafanalogin.png?raw=true" width="300" alt="Grafana Dashboard">

**Grafana Kubernetes Dashboard:**

<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/grafana.png?raw=true" width="800" alt="Grafana Dashboard">
<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/grafana2.png?raw=true" width="800" alt="Grafana Dashboard">

---

### ✅ CI/CD Pipeline via GitHub Actions

Every change to the codebase or infrastructure triggers GitHub Actions workflows that run Docker builds, security scans, Terraform plans, and apply changes automatically upon merge.

**Successful CI/CD Workflow Execution:**

<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/docker-build.png?raw=true" width="300" alt="GitHub Actions Success">
<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/tf-plan.png?raw=true" width="300" alt="GitHub Actions Success">
<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/tf-apply.png?raw=true" width="300" alt="GitHub Actions Success">
<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/tf-destroy.png?raw=true" width="300" alt="GitHub Actions Success">

---

### ✅ Cloudflare DNS Configuration

The Kanban board app and monitoring tools are publicly accessible via custom subdomains managed in **Cloudflare**.

DNS `CNAME` records are configured in Cloudflare to point to the Azure Ingress or Front Door endpoints for the following services:

- `kanban.hanadisa.com` → Kanban board app
- `grafana.hanadisa.com` → Grafana dashboards
- `prometheus.hanadisa.com` → Prometheus monitoring UI

This setup enables:

- Clean, branded, and user-friendly URLs
- Real-time DNS resolution via **ExternalDNS**
- Secure HTTPS access via certificates provisioned by **Cert-Manager**

<img src="https://github.com/hanadisa/aks-gitops-kanban/blob/main/docs/images/dnsrecord.png?raw=true" width="650" alt="Cloudflare DNS Record">


## 📜 License

Licensed under MIT License.
