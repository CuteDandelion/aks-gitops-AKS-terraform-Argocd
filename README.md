## Overview

This project sets up a cloud-native **Kanban board app** on a Production-grade **Kubernetes cluster** running on **Azure Kubernetes Service (AKS)**. It uses **Terraform** to handle the entire infrastructure on **Azure**, and **GitHub Actions** powers a reliable **CI/CD pipeline**. An **Azure Container Registry (ACR)** is created for managing **Docker images**, and the **NGINX Ingress Controller** is used to manage global traffic securely and efficiently—including **HTTPS** support. The setup is designed for scalability, security, and smooth performance. It includes **Cert-Manager** for automatic **SSL certificates**, **ExternalDNS** for real-time DNS updates, **Helm** for managing **Kubernetes packages**, **ArgoCD** for **GitOps-based** deployment, and **Prometheus** & **Grafana** for full-stack monitoring and visibility.

## End-to-End Architecture Diagram
<img width="1180" height="550" alt="AzureInfra drawio" src="https://github.com/user-attachments/assets/37dd1454-9cca-419d-bde3-cf6bc5839d38" />

---

## Application

<img width="1895" height="1003" alt="aks-kanbanboard" src="https://github.com/user-attachments/assets/098a133d-064e-49cd-863e-3dfd5ad63d42" />

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

<img width="1917" height="1065" alt="aks-argocd" src="https://github.com/user-attachments/assets/e8d66d7e-1cec-4af2-bb10-a3efdd3d15ff" />

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

<img width="1890" height="1001" alt="aks-gitbuild" src="https://github.com/user-attachments/assets/2ec90d36-6785-47ab-a327-dc80f094a1ad" />
<img width="1880" height="998" alt="aks-gitplan" src="https://github.com/user-attachments/assets/dfe794e0-c8a5-4fb2-9b30-f9e0453f4204" />
<img width="1897" height="992" alt="aks-gitapply" src="https://github.com/user-attachments/assets/93866e80-72e2-47c2-808b-5eb6b22a5156" />

**Results:******

<img width="1918" height="1057" alt="aks-containerregistry" src="https://github.com/user-attachments/assets/0c5bafe4-35b0-463d-8464-ae9d948723f3" />
<img width="1892" height="927" alt="aks-azureresource" src="https://github.com/user-attachments/assets/93bf9c3d-db1e-4218-9bf6-05bfa0076195" />
<img width="1912" height="1005" alt="aks-kubectl" src="https://github.com/user-attachments/assets/19b87c15-82b0-4c51-aed0-e986ce412c78" />

---

### ✅ Cloudflare DNS Configuration

The Kanban board app and monitoring tools are publicly accessible via custom subdomains managed in **Cloudflare**.

DNS `CNAME` records are configured in Cloudflare to point to the Azure Ingress or Front Door endpoints for the following services:

- `kanban.misakirose.com` → Kanban board app
- `grafana.misakirose.com` → Grafana dashboards
- `prometheus.misakirose.com` → Prometheus monitoring UI

This setup enables:

- Clean, branded, and user-friendly URLs
- Real-time DNS resolution via **ExternalDNS**
- Secure HTTPS access via certificates provisioned by **Cert-Manager**

<img width="1877" height="896" alt="aks-cloudflare" src="https://github.com/user-attachments/assets/2c993e4d-dd2e-41a2-a2da-280c1134f9b6" />

## 📜 License

Licensed under MIT License.


