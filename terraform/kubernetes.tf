resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
  depends_on = [
    module.aks
  ]
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
  depends_on = [
    module.aks
  ]
}

resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = "external-dns"
  }
  depends_on = [
    module.aks
  ]
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
  depends_on = [
    module.aks
  ]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
  depends_on = [
    module.aks
  ]
}

resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = kubernetes_namespace.ingress_nginx.metadata[0].name
  create_namespace = false
  version          = "4.10.0"

  values = [
    file("../k8s-manifests/ingress/nginx-ingress.yml")
  ]

  depends_on = [
    module.aks,
    kubernetes_namespace.ingress_nginx
  ]
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.13.3"
  namespace        = kubernetes_namespace.cert_manager.metadata[0].name
  create_namespace = false
  timeout          = 900

  values = [
    file("../k8s-manifests/cert-manager/cert-manager.yml")
  ]

  depends_on = [
    helm_release.nginx_ingress,
    kubernetes_secret.cloudflare_api_token,
    kubernetes_namespace.cert_manager
  ]
}

resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = kubernetes_namespace.cert_manager.metadata[0].name
  }
  data = {
    "api-token" = var.cloudflare_api_token
  }
  type = "Opaque"
  depends_on = [
    kubernetes_namespace.cert_manager
  ]
}

resource "kubectl_manifest" "cert_manager_cluster_issuer_staging" {
  yaml_body = file("../k8s-manifests/cert-manager/issuer.yml")
  depends_on = [
    helm_release.cert_manager
  ]
}

resource "helm_release" "external_dns" {
  name             = "external-dns"
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  chart            = "external-dns"
  version          = "1.14.0"
  namespace        = kubernetes_namespace.external_dns.metadata[0].name
  create_namespace = false
  timeout          = 600
  wait             = false

  values = [
    file("../k8s-manifests/external-dns/external-dns.yml")
  ]

  depends_on = [
    helm_release.cert_manager,
    kubernetes_namespace.external_dns
  ]
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  timeout          = "600"
  version          = "5.24.1"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = false
  wait             = false

  values = [
    file("../k8s-manifests/argocd/argocd.yml")
  ]

  depends_on = [
    helm_release.nginx_ingress,
    helm_release.cert_manager,
    kubernetes_namespace.argocd
  ]
}

resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "56.8.0"
  namespace        = kubernetes_namespace.monitoring.metadata[0].name
  create_namespace = false

  values = [
    file("../k8s-manifests/monitoring/kube-prometheus-stack.yml")
  ]

  depends_on = [
    helm_release.nginx_ingress,
    kubernetes_namespace.monitoring
  ]
}