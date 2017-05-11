# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false
  config.vbguest.auto_update = false
  config.vbguest.no_remote= false
  config.vm.define "local.bulochnik.com" do |node|
    node.vm.box = "ubuntu/xenial64"
    node.vm.hostname = "local.bulochnik.com"
    node.hostmanager.aliases = %w(local.bulochnik.com dev.local.bulochnik.com preview.local.bulochnik.com)
    node.vm.network :private_network, ip: "192.168.56.2"
    node.vm.provider :virtualbox do |vb|
      vb.name = "local.bulochnik.com"
      vb.memory = 2048
    end
    node.vm.provision :shell, inline: <<-SHELL
    /vagrant/ttyjs_provisioner.sh yevgeny devops#1
    SHELL
  end
end
