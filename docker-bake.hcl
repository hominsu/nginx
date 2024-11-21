target "metadata" {}

variable "ENABLED_MODULES"  {
  default = "geoip2 rtmp"
}

group "default" {
  targets = [
    "nginx",
  ]
}

target "cross" {
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
}

target "nginx" {
  inherits = ["metadata", "cross"]
  contexts = {
    "nginx" = "docker-image://nginx:${target.metadata.args.DOCKER_META_VERSION}"
  }
  dockerfile = "Dockerfile"
  args = {
    ENABLED_MODULES = "${ENABLED_MODULES}"
  }
}
