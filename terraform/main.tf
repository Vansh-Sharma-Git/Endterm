provider "kubernetes" {
  config_path = var.kubeconfig
}

resource "kubernetes_deployment" "demo_app" {
  metadata {
    name = "demo-app"
    labels = {
      app = "demo-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "demo-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "demo-app"
        }
      }

      spec {
        container {
          image = var.docker_image
          name  = "demo-app"

          ports {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "demo_app" {
  metadata {
    name = "demo-app"
  }

  spec {
    selector = {
      app = "demo-app"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
