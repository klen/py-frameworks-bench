# vi: set ft=ruby:fdm=marker

# Options {{{
#
APP_HOST = "33.33.33.8"
APP_HOSTNAME = "benchmark.local"

# }}}


# Vagrant 2.0.x {{{
#
Vagrant.configure("2") do |config|
 
    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    # We provide default vagrant key
    config.ssh.insert_key = false

    # Set hostname
    config.vm.hostname = APP_HOSTNAME

    # Configure network
    config.vm.network :private_network, ip: APP_HOST

    # Configure provider
    config.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--name", APP_HOSTNAME]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    config.ssh.forward_agent = true

end
# }}}
