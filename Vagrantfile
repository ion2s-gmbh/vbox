require "yaml"
require "erb"

# Get and print version information
VBOX_VERSION = File.read("VERSION")
puts "-> Vbox #{VBOX_VERSION}"

########################################################################################################################
# Load the box configuration
#
# Tries to load the yml file:
# 1) from outside the vbox folder (../)
# 2) from the vbox folder
# 3) from vbox/configure folder
########################################################################################################################
external = File.join(__dir__, "..", "box.yml")
internal = File.join(__dir__, "box.yml")
nested = File.join(__dir__, "configure", "box.yml")
configPath = nested if (File.exist?(nested))
configPath = internal if (File.exist?(internal))
configPath = external if (File.exist?(external))
if (configPath.nil?)
  raise "No box.yml found. Copy and paste configure/box.sample.yml in your main project and name it box.yml."
end

configure = YAML.load_file(configPath)
puts "-> Used box configuration: #{configPath}"

########################################################################################################################
# Override box configuration with individual per developer configuratins.
########################################################################################################################
externalOverride = File.join(__dir__, "..", "box.override.yml")
internalOverride = File.join(__dir__, "box.override.yml")
nestedOverride = File.join(__dir__, "configure", "box.override.yml")
overridePath = nestedOverride if (File.exist?(nestedOverride))
overridePath = internalOverride if (File.exist?(internalOverride))
overridePath = externalOverride if (File.exist?(externalOverride))

if (overridePath.nil?)
  puts "-> No override of box.yml is provided."
else
  configOverrides = YAML.load_file(overridePath)
  configure.merge!(configOverrides)
  puts "-> Overriding box.yml configuration with values from #{overridePath}."
end

########################################################################################################################
# Generate webserver configs
########################################################################################################################
vars = configure
nginxConf = ERB.new File.read("provisioning/templates/nginx/nginx-default.conf.erb")
File.write("provisioning/templates/nginx/nginx-default.conf", nginxConf.result(binding))

apacheConf = ERB.new File.read("provisioning/templates/apache/000-default.conf.erb")
File.write("provisioning/templates/apache/000-default.conf", apacheConf.result(binding))

########################################################################################################################
# Vagrant provisioning
########################################################################################################################
Vagrant.configure("2") do |config|

  config.vagrant.plugins = configure["PLUGINS"] || []

  config.vm.box = configure["BOX_BASE"]

  # Fix the version and disable check of updates
  config.vm.box_version = configure["BOX_VERSION"]
  config.vm.box_check_update = configure["BOX_CHECK_UPDATES"] || false

  # Give your box a name, that is displayed in the commandline and in
  # the VirtualBox"s bash.
  config.vm.define configure["BOX_NAME"] do |vm| end
  config.vm.host_name = configure["BOX_NAME"]

  # Assign private IP address for the box
  config.vm.network "private_network", ip: configure["BOX_IP"]

  # Port forwarding
  if !configure["ports"].nil?
    configure["ports"].each do |port|
      config.vm.network "forwarded_port",
       guest: port["box"],
       host: port["localhost"]
    end
  end

  # Shared folder
  unless configure["folders"].nil?
    configure["folders"].each do |folder|
      owner = (folder["owner"].nil?) ? "vagrant" : folder["owner"]
      group = (folder["group"].nil?) ? "vagrant" : folder["group"]
      config.vm.synced_folder folder["host"], folder["guest"],
       owner: owner,
       group: group
    end
  end

  config.vm.provider "virtualbox" do |vb|
    # Give your box a name, that is displayed in the VirtualBox Manager
    vb.name = configure["BOX_NAME"]

    # Allocate CPU and memory
    vb.cpus = configure["BOX_CPU"]
    vb.memory = configure["BOX_MEMORY"]
  end

  # Add extra ca certificates to the box
  if !configure["extra_certificates"].nil? && !configure["extra_certificates"].empty?
    config.vm.provision "file", source: configure["extra_certificates"], destination: "/home/vagrant/extra"
    config.vm.provision "add-cas",
     type: "shell",
     path: "provisioning/add-cas.sh"
  end

  # Packages preprovision
  packages = configure["packages"]
  if !packages["preprovision"].nil? && !packages["preprovision"].empty?
    # Basic tools provisioning
    config.vm.provision "preprovision",
     type: "shell",
     path: "provisioning/packages.sh",
     env: {"PACKAGES" => packages["preprovision"].join(" ")}
  end

  # PHP
  if configure["provision"]["php"]

    # Copy custom php.ini file
    if !configure["php"]["ini_path"].nil? && !configure["php"]["ini_path"].empty?
      config.vm.provision "file", source: configure["php"]["ini_path"], destination: "/home/vagrant/php/php.ini"
    end

    configure["php"]["versions"].each do |version|

        # Prepare php modules
        if !configure["php"]["modules"].nil? && !configure["php"]["modules"].empty?
            modules = Array.new
            configure["php"]["modules"].each do |mod|
                modules.push("php#{version}-#{mod}")
            end
            mods = modules.join(" ")
        end
      config.vm.provision "php-#{version}",
       type: "shell",
       path: "provisioning/php.sh",
       env: {
         "PHP_VERSION" => version,
         "PHP_MODULES" => mods,
         "PHP_CURRENT" => configure["php"]["current"],
         "PHP_INI" => configure["php"]["php_ini"]
       }

       if configure["php"]["ioncube"]
         config.vm.provision "ioncube-#{version}",
         type: "shell",
         path: "provisioning/ioncube.sh",
         env: {
           "PHP_VERSION" => version
         }
       end
    end
    config.vm.provision "composer",
     type: "shell",
     path: "provisioning/composer.sh"
  end

  if configure["USE_SSL"]
    config.vm.provision "SSL",
     type: "shell",
     path: "provisioning/createSSLCert.sh",
     env: configure
  end

  # Nginx
  if configure["provision"]["nginx"]
    config.vm.provision "nginx",
     type: "shell",
     path: "provisioning/nginx.sh"
  end

  # Apache
  if configure["provision"]["apache"]
    config.vm.provision "apache",
     type: "shell",
     path: "provisioning/apache.sh",
     env: {"PHP_VERSION" => configure["php"]["current"]}
  end

  # Node
  if configure["provision"]["nvm"]
    node_versions = configure["node"] ? configure["node"]["versions"].join(" ") : 'lts/erbium'
    current_version = configure["node"] ? configure["node"]["current"] : 'lts/erbium'
    config.vm.provision "nvm",
     type: "shell",
     path: "provisioning/nvm.sh",
     env: {
       "versions_string" => node_versions,
       "current" => current_version
     },
     privileged: false
  end

  # Mysql
  if configure["provision"]["mysql"]
    if !configure["mysql"]["MYSQL_MIGRATION_FILE"].nil? && File.exist?(configure["mysql"]["MYSQL_MIGRATION_FILE"])
        config.vm.provision "file", source: configure["mysql"]["MYSQL_MIGRATION_FILE"], destination: "/tmp/mysql/migration.sql"
    end
    config.vm.provision "mysql",
     type: "shell",
     path: "provisioning/mysql.sh",
     env: configure["mysql"]
  end

  # MongoDB
  if configure["provision"]["mongodb"]
    config.vm.provision "mongodb",
     type: "shell",
     path: "provisioning/mongodb.sh"
  end

  # MailHog
  if configure["provision"]["mailhog"]
    config.vm.provision "mailhog",
     type: "shell",
     path: "provisioning/mailhog.sh"
  end

  # Memcached
  if configure["provision"]["memcached"]
    config.vm.provision "memcached",
     type: "shell",
     path: "provisioning/memcached.sh"
  end

  # Redis
  if configure["provision"]["redis"]
    config.vm.provision "redis",
     type: "shell",
     path: "provisioning/redis.sh"
  end

  # Docker
  if configure["provision"]["docker"]
    config.vm.provision "docker",
     type: "shell",
     path: "provisioning/docker.sh"
    config.vm.provision "docker-compose",
     type: "shell",
     path: "provisioning/docker-compose.sh"
  end

  # Welcome screen
  if configure["provision"]["welcome"]
    config.vm.provision "welcome",
     type: "shell",
     path: "provisioning/welcome.sh",
     privileged: false
  end

  # Frameworks
  if configure["provision"]["frameworks"]
    config.vm.provision "frameworks",
     type: "shell",
     path: "provisioning/frameworks.sh",
     privileged: false
  end

  # Custom
  if configure["provision"]["custom"]
    configure["custom"]["scripts"].each do |script|
      config.vm.provision script["name"],
       type: "shell",
       path: script["path"],
       privileged: script["privileged"] || true,
       env: script["env"] || {}
    end
  end

  # Packages post install
  if !packages["postprovision"].nil? && !packages["postprovision"].empty?
    config.vm.provision "postprovision",
     type: "shell",
     path: "provisioning/packages.sh",
     env: {"PACKAGES" => packages["postprovision"].join(" ")}
  end

  # Open default browser on host
  if configure["OPEN_BROWSER"] && (configure["provision"]["nginx"] || configure["provision"]["apache"])
    config.trigger.after [:up] do |trigger|

      trigger.name = "Up and running"
      trigger.info = "Vbox is up and running. Build something amazing."
      if Vagrant::Util::Platform.linux?
        trigger.run = {inline: "xdg-open http://#{configure['BOX_IP']}"}
      end
      if Vagrant::Util::Platform.windows?
        trigger.run = {inline: "start http://#{configure['BOX_IP']}"}
      end
    end
  end
end
