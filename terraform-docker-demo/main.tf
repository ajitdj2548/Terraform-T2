terraform {
  required_version = ">= 1.0.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"    # pin to a provider version you tested; optional but recommended
    }
  }
}

provider "docker" {
  # By default the provider will use DOCKER_HOST env var or the default unix socket.
  # If you need to force an endpoint, uncomment one of these examples:
  # Unix (Linux/Mac): host = "unix:///var/run/docker.sock"
  # Windows named pipe: host = "npipe:////./pipe/docker_engine"
}

resource "docker_image" "nginx" {
  name         = "nginx:stable-alpine"
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = "demo-nginx"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
}
