# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  # Let's call the host something contextual
  config.vm.hostname = "tidepool-vm"
  
  # Port forwards for Blip, Shoreline and Chrome Uploader
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 8009, host: 8009
  config.vm.network "forwarded_port", guest: 9122, host: 9122
  config.vm.network "forwarded_port", guest: 3004, host: 3004

  # Let's make the VM accessible via a static local IP too
  config.vm.network "private_network", ip: "192.168.33.100"
  
  # Set the memory available and number of cpus when using VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end
  
  # Set the memory available when using Paralells
  config.vm.provider "parallels" do |v|
    v.memory = "2048"
  end

  config.vm.provision "bootstrap", type: "shell" do |s|
    s.path = "bootstrap.sh"
  end

  config.vm.provision "tools", type: "shell" do |tools|
    tools.path = "tools.sh"
  end

  config.vm.provision "tidepool", type: "file" do |f|
    f.source = "tidepool.sh"
	f.destination = "tidepool.sh"
  end
  
  config.vm.provision "profile", type: "shell" do |p|
    p.inline = "mv /home/vagrant/tidepool.sh /etc/profile.d/"
  end
  
end
