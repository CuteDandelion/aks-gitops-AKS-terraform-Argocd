resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  create_namespace = true
  version    = "4.10.0"

  values = [
    file("../k8s-manifests/ingress/nginx-ingress.yml")
  ]

  depends_on = [
    module.aks
  ]
}


resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.13.3"
  namespace  = "cert-manager"
  create_namespace = true
  timeout    = 900

  values = [
    file("../k8s-manifests/cert-manager/cert-manager.yml")
  ]

  depends_on = [
    helm_release.nginx_ingress,
    kubernetes_secret.cloudflare_api_token
  ]
}

resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = "cert-manager"
  }
  data = {
    "api-token" = var.cloudflare_api_token
  }
  type = "Opaque"
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = "1.14.0"
  namespace  = "external-dns"
  create_namespace = true
  timeout    = 600
  wait       = false

  values = [
    file("../k8s-manifests/external-dns/external-dns.yml")
  ]

  depends_on = [
    helm_release.cert_manager
  ]
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  timeout    = "600"
  version    = "5.24.1"
  namespace  = "argocd"
  create_namespace = true
  wait       = false

  values = [
    file("../k8s-manifests/argocd/argocd.yml")
  ]

  depends_on = [
    helm_release.nginx_ingress,
    helm_release.cert_manager
  ]
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "56.8.0"
  namespace  = "monitoring"
  create_namespace = true

  values = [
    file("../k8s-manifests/monitoring/kube-prometheus-stack.yml")
  ]

  depends_on = [
    helm_release.nginx_ingress,
  ]
}