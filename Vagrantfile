# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.network “forwarded_port”, guest: 80, host: 5000
  config.vm.network “forwarded_port”, guest: 8080, host: 5001
  config.vm.network “forwarded_port”, guest: 8888, host: 5002

  config.vm.provision :shell, path: "bootstrap.sh"
end
