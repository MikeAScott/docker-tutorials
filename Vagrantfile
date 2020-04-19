# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANT_API_VERSION = "2"

docker_IP     = "192.168.35.40"

Vagrant.configure(VAGRANT_API_VERSION) do |config|

  config.vm.define "docker" do |docker|
    docker.vm.box = "ubuntu/bionic64"
    docker.vm.hostname = 'docker'
    docker.vm.network :private_network, ip: docker_IP
    docker.vm.network "forwarded_port",id: "tomcat", guest: 8080, host: 8080

    docker.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    docker.vm.provision "shell", inline: <<-SCRIPT
        apt-get update -y
        apt-get install docker docker.io -y
        groupadd docker
        usermod -aG docker vagrant
        systemctl start docker
    SCRIPT
  end

end
