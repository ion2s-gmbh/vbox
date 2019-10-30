BOX_BASE = "ubuntu/bionic64"
BOX_NAME = "vbox"
BOX_VERSION = "20190726.0.0"
BOX_IP = "10.0.0.42"
BOX_CPU = 2
BOX_MEMORY = 4096
HOST_SRC_FOLDER = "./src"

Vagrant.configure("2") do |config|
  config.vm.box = BOX_BASE

  # Fix the version and disable check of updates
  config.vm.box_version = BOX_VERSION
  config.vm.box_check_update = false

  # Give your box a name, that is displayed in the commandline and in
  # the VirtualBox's bash.
  config.vm.define BOX_NAME do |vm| end
  config.vm.host_name = BOX_NAME

  # Assigne private IP address for the box
  config.vm.network "private_network", ip: BOX_IP
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Shared folder
  config.vm.synced_folder HOST_SRC_FOLDER, "/var/www/html"

  config.vm.provider "virtualbox" do |vb|
      # Give your box a name, that is displayed in the VirtualBox Manager
      vb.name = BOX_NAME

      # Allocate CPU and memory
      vb.cpus = BOX_CPU
      vb.memory = BOX_MEMORY
  end

  config.vm.provision "base", type: "shell", path: "provisioning/base.sh"
  config.vm.provision "nginx", type: "shell", path: "provisioning/nginx.sh"
  config.vm.provision "php-7.2", type: "shell", path: "provisioning/php-72.sh"
  config.vm.provision "composer", type: "shell", path: "provisioning/composer.sh"
  config.vm.provision "configure", type: "shell", path: "provisioning/configure.sh"
  config.vm.provision "nvm", type: "shell", path: "provisioning/nvm.sh"
  config.vm.provision "docker", type: "shell", path: "provisioning/docker.sh"
  config.vm.provision "docker-compose", type: "shell", path: "provisioning/docker-compose.sh"
end
