# -*- mode: ruby -*-
# vi: set ft=ruby :


#
# Vagrant configuration for sigmah-vagrant-box
# @link
# https://github.com/spMohanty/sigmah-vagrant-box
#
Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.box = "precise64"

  # Grab this via `vagrant box add precise64 http://files.vagrantup.com/precise64.box`
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Forward ports
  config.vm.network :forwarded_port, guest: 8080,    host: 8080    # Java app server; jetty
  config.vm.network :forwarded_port, guest: 5432,    host: 5432    # Postgres DB

  # Allow vagrant to access hosts internet
  config.vm.provider :virtualbox do |vb|
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
     vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Share the working dir - host, guest
  config.vm.synced_folder "shared", "/vagrant"

  config.vm.provision "shell", inline: "apt-get update --fix-missing"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "base.pp"
     puppet.module_path = "puppet/modules"
     puppet.options = "--verbose"
  end

end
