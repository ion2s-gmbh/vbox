
# Load the box configuration
require 'yaml'
configure = YAML.load_file('configure/box.yml')

Vagrant.configure("2") do |config|
  config.vm.box = configure["BOX_BASE"]

  # Fix the version and disable check of updates
  config.vm.box_version = configure["BOX_VERSION"]
  config.vm.box_check_update = false

  # Give your box a name, that is displayed in the commandline and in
  # the VirtualBox's bash.
  config.vm.define configure["BOX_NAME"] do |vm| end
  config.vm.host_name = configure["BOX_NAME"]

  # Assign private IP address for the box
  config.vm.network "private_network", ip: configure["BOX_IP"]

  # Shared folder
  config.vm.synced_folder configure["HOST_SRC_FOLDER"], "/var/www/html"

  config.vm.provider "virtualbox" do |vb|
      # Give your box a name, that is displayed in the VirtualBox Manager
      vb.name = configure["BOX_NAME"]

      # Allocate CPU and memory
      vb.cpus = configure["BOX_CPU"]
      vb.memory = configure["BOX_MEMORY"]
  end

  # Base
  config.vm.provision "base", type: "shell", path: "provisioning/base.sh"

  configure["provision"].each do |provision|

      # Webserver & PHP
      if provision["nginx"]
          config.vm.provision "nginx", type: "shell", path: "provisioning/nginx.sh"
          config.vm.provision "php-7.2", type: "shell", path: "provisioning/php-72.sh"
          config.vm.provision "composer", type: "shell", path: "provisioning/composer.sh"
          config.vm.provision "configure", type: "shell", path: "provisioning/configure.sh"
      end

      # Node
      if provision["nvm"]
          config.vm.provision "nvm", type: "shell", path: "provisioning/nvm.sh", privileged: false
      end

      # Databases
      if provision["mysql"]
          config.vm.provision "mysql", type: "shell", path: "provisioning/mysql.sh"
      end

      # Docker
      if provision["docker"]
          config.vm.provision "docker", type: "shell", path: "provisioning/docker.sh"
          config.vm.provision "docker-compose", type: "shell", path: "provisioning/docker-compose.sh"
      end
    end
end
