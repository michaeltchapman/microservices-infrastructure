# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

def load_security
  fname = File.join(File.dirname(__FILE__), "security.yml")
  if !File.exist? fname
    $stderr.puts "security.yml not found - please run `./security-setup` and try again."
    exit 1
  end

  YAML.load_file(fname)
end

Vagrant.configure(2) do |config|

  # Prefer VirtualBox before VMware Fusion
  config.vm.provider "virtualbox"
  config.vm.provider "vmware_fusion"

  config.vm.box = "CiscoCloud/microservices-infrastructure"

  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  config.vm.network "private_network", :ip => "192.168.242.55"

  config.vm.provision "shell" do |s|
    s.path = "vagrant/provision.sh"
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--cpus', 1]
    vb.customize ['modifyvm', :id, '--memory', 1536]
  end
end
