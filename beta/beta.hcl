data_dir = "/tmp/nomad"

client {
  enabled = true
  options {
    "consul.address" = "10.0.2.2:8500"
    "docker.auth.config" = "/home/docker/nomad-demo/config.json"
  }
  node_class = "beta"
  servers = ["10.0.2.2"]
}

