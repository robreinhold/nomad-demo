data_dir = "/tmp/nomad"

server {
  enabled = true
  bootstrap_expect = 1
  data_dir = "/tmp/nomad"
}

client {
  enabled = true
  options {
    "consul.address" = "127.0.0.1:8500"
    "docker.auth.config" = "~/.docker/config.json"
  }
  node_class = "mac"
}

