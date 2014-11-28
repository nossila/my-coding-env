# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "../", "/home/vagrant/work"
  config.vm.synced_folder "~/.ssh", "/home/vagrant/.ssh"

  config.vm.provision "docker" do |docker|
      docker.pull_images "alisson/my-coding-env"
      docker.pull_images "golang:onbuild"
      docker.run "alisson/my-coding-env",
          args: "-v /var/run/docker.sock:/container/var/run/docker.sock -v /home/vagrant/work:/home/alisson/work -v /home/vagrant/.ssh:/home/alisson/.ssh -i -t"
  end
end
