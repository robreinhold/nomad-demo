# There can only be a single job definition per file.
# Create a job with ID and Name 'example'
job "iptv" {
  # Run the job in the global region, which is the default.
  # region = "global"

  # Specify the datacenters within the region this job can run in.
  datacenters = [
    "dc1"]

  # Service type jobs optimize for long-lived services. This is
  # the default but we can change to batch for short-lived tasks.
  # type = "service"

  # Priority controls our access to resources and scheduling priority.
  # This can be 1 to 100, inclusively, and defaults to 50.
  # priority = 50

  # Constrain to VM
  constraint {
    attribute = "${node.class}"
    value = "vm"
  }
  # Configure the job to do rolling updates
  update {
    # Stagger updates every 10 seconds
    stagger = "10s"

    # Update a single task at a time
    max_parallel = 1
  }

  # Create a 'cache' group. Each task in the group will be
  # scheduled onto the same machine.
  group "packager-nginx" {
    # Control the number of instances of this groups.
    # Defaults to 1
    # count = 1

    # Configure the restart policy for the task group. If not provided, a
    # default is used based on the job type.
    restart {
      # The number of attempts to run the job within the specified interval.
      attempts = 10
      interval = "5m"

      # A delay between a task failing and a restart occurring.
      delay = "25s"

      # Mode controls what happens when a task has restarted "attempts"
      # times within the interval. "delay" mode delays the next restart
      # till the next interval. "fail" mode does not restart the task if
      # "attempts" has been hit within the interval.
      mode = "delay"
    }

    # Define a task to run
    task "manager" {
      # Use Docker to run the task.
      driver = "docker"

      # Configure Docker driver with the image
      config {
        image = "gogoair-docker-build-poc.jfrog.io/a_iptv_manager:1.2.0.160"
      }

      service {
        name = "iptv-manager"
        tags = [
          "global",
          "iptv"]
      }

      # We must specify the resources required for
      # this task to ensure it runs on a machine with
      # enough capacity.
      resources {
        cpu = 500
        # 500 Mhz
        memory = 256
        # 256MB
        network {
          mbits = 10
        }
      }
    }

    task "nginx" {
      # Use Docker to run the task.
      driver = "docker"

      # Configure Docker driver with the image
      config {
        image = "gogoair-docker-build-poc.jfrog.io/a_iptv_nginx:0.2.0.14"
        port_map {
          http = 80
        }
      }

      service {
        name = "iptv-nginx"
        tags = [
          "global",
          "iptv"]
        port = "http"
        check {
          name = "alive"
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }

      # We must specify the resources required for
      # this task to ensure it runs on a machine with
      # enough capacity.
      resources {
        cpu = 500
        # 500 Mhz
        memory = 256
        # 256MB
        network {
          mbits = 10
          port "http" {
          }
        }
      }
    }
  }
}
