# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'chef/centos-6.5'
 
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]

    chef.add_recipe "yum"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rvm"
    chef.add_recipe "mongodb"
    chef.add_recipe "vim"

    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.1.5"],
          global: "2.1.5",
          gems: {
            "2.1.5" => [
              { name: "bundler" }
            ]
          }
        }]
      }
    }
  end

end

