output "app_url" {
  value = kubernetes_service.demo_app.status[0].load_balancer.ingress[0].hostname
  description = "URL of the demo app"
}
