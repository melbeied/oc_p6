# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.box = "debian/buster64" #Ubuntu

  config.vm.define "cicd" do |cicd|
    cicd.vm.define  "cicd-server"
    cicd.vm.hostname = "casablanca"

    cicd.vm.network "forwarded_port", guest: 80, host: 8000
    cicd.vm.network "private_network", ip: "192.168.34.100" 
    cicd.vm.synced_folder "./resources", "/vagrant", type: "rsync"
    cicd.vm.provider "virtualbox" do |v|
      v.cpus = 4
      v.memory = 3078
    end
    cicd.vm.provision "shell", path: "ext/ansible.sh"
    cicd.vm.provision 'ansible' do |ansible|
      ansible.playbook = "ext/docker-playbook.yml"
    end
    cicd.vm.provision :shell, inline: "export ANSIBLE_HOST_KEY_CHECKING=False"
  end

  config.vm.define "recette" do |recette|
    recette.vm.define "runner_uat"

    recette.vm.box = "debian/buster64"
    recette.vm.hostname = "dakar"

    recette.vm.network "forwarded_port", guest: 8000, host: 8010
    recette.vm.network "private_network", ip: "192.168.34.10" 
    recette.vm.synced_folder "./source", "/vagrant", type: "rsync"
    recette.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 1542
    end    
    recette.vm.provision "shell", path: "ext/runner.sh"
  end

  config.vm.define "production" do |production|
    production.vm.define "runner_production"

    production.vm.box = "debian/buster64"
    production.vm.hostname = "bamako"

    production.vm.network "forwarded_port", guest: 8000, host: 8020
    production.vm.network "private_network", ip: "192.168.34.20" 
    production.vm.synced_folder "./source", "/vagrant", type: "rsync"
    production.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 1542
    end
    production.vm.provision "shell", path: "ext/runner.sh"
  end
end

