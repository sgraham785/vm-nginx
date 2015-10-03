# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
# VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(2) do |config|

  config.vm.box = "centos6.6-nginx-pg.box"

  config.vm.box_url = "box/centos6.6-nginx-pg.box"

  # Define port forwarding
  config.vm.network :forwarded_port, guest: 80, host: 8081
  config.vm.network :forwarded_port, guest: 81, host: 8182
  config.vm.network :forwarded_port, guest: 3000, host: 3001
  config.vm.network :forwarded_port, guest: 5432, host: 25432
  # config.vm.network :forwarded_port, guest: 3306, host: 23306

  # Define Vagrant box IP edit xx is multiple boxes at once (192.168.xx.10)
  config.vm.network :private_network, ip: "192.168.19.10"

  #config.vm.synced_folder "public", "/var/www",
  #    nfs: { mount_options: ["dmode=777", "fmode=777", "vers=4,nolock,udp"] }

  ## Non NFS
  config.vm.synced_folder "public", "/var/www", :nfs => false, :mount_options => ["dmode=777","fmode=777"]

  # Set MEM & CPU for virtualbox to use
      config.vm.provider "virtualbox" do |v|
        host = RbConfig::CONFIG['host_os']

        # Give VM 1/4 system memory & access to all cpu cores on the host
        if host =~ /darwin/
          cpus = `sysctl -n hw.ncpu`.to_i
          # sysctl returns Bytes and we need to convert to MB
          mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
        elsif host =~ /linux/
          cpus = `nproc`.to_i
          # meminfo shows KB and we need to convert to MB
          mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
        else # sorry Windows folks, I can't help you
          cpus = 2
          mem = 1024
        end

        v.memory = mem
        v.cpus = cpus
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        v.customize ["modifyvm", :id, "--nictype1", "virtio"]

      end

    # Provision Scripts - hash out ones you don't want

    # Core Packages
    config.vm.provision :shell, :path => "scripts/packages.sh", keep_color: true
    config.vm.provision :shell, :path => "scripts/config.sh", keep_color: true

    # Language Packages
    # config.vm.provision :shell, :path => "scripts/php.sh", keep_color: true
    config.vm.provision :shell, :path => "scripts/nodejs.sh", keep_color: true

    # DB Packages
    config.vm.provision :shell, :path => "scripts/postgresql.sh", keep_color: true

    # Utility Packages
    config.vm.provision :shell, :path => "scripts/git.sh", keep_color: true
    config.vm.provision :shell, :path => "scripts/zsh.sh", keep_color: true
    config.vm.provision :shell, :path => "scripts/utils.sh", keep_color: true
    config.vm.provision :shell, :path => "scripts/kss.sh", keep_color: true

    # A little house cleaning
    config.vm.provision :shell, :path => "scripts/cleanup.sh", keep_color: true

    # Run startup script on up & reload always
    config.vm.provision "shell", inline: "sh /vagrant/scripts/startup.sh", run: "always", keep_color: true

  end
