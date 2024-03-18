variable "REPO" {
  default = "hominsu"
}

variable "VERSION" {
  default = ""
}

group "default" {
  targets = [
    "nginx",
  ]
}

target "nginx" {
  context    = "."
  dockerfile = "Dockerfile"
  args       = {
    ENABLED_MODULES = "geoip2"
  }
  tags = [
    notequal("", VERSION) ? "${REPO}/nginx:${VERSION}" : "",
    "${REPO}/nginx:latest",
  ]
  platforms = [
    "linux/386",
    "linux/amd64",
    "linux/arm/v5",
    "linux/arm/v7",
    "linux/arm64",
  ]
}
