# Vagrant Dev Box

* CentOs 6.6
* NGINX
* Nodejs
* PostgreSQL 9.4

Install the following dependancies:

[Vagrant 1.7.2](http://www.vagrantup.com/downloads.html)

[vagrant-vbguest - latest(master)](https://github.com/dotless-de/vagrant-vbguest)

[VirtualBox 4.3.22](https://www.virtualbox.org/wiki/Downloads)

[Packer 0.7.5](http://www.packer.io/downloads.html)


After those are installed clone this repo where ever you would like :)

You can define "iso_urls" in packer.json to a more locale download region. Just make sure it's the same version e.g. CentOS 6.6

NOTE: The ISO should only download on first run after that it with cache to your system, making installs faster in the future

* `cd /path/to/vm-nginx`

Now run:

* `./build`

This will install the entire base vm environment

Add this to your LOCAL host file, usually found `/etc/hosts`

```
192.168.19.10 vagrant.vm
```

Directory map:
* HOST: `/vm-nginx/public`
* GUEST: `/var/www`

Add additional vhost conf's here:
* HOST: `/vm-nginx/public/conf`
* GUEST: `/var/www/conf`

Clone all other apps here:
* HOST: `/vm-nginx/public/html`
* GUEST: `/var/www/html`



## Helpful Tips for Vagrant Install

**NOTE: if on Windows I am assuming that you've got Cygwin or similar installed. To clarify, Windows does not have a built-in utility to support .sh files. To run such, you'll need to install a third-party tool such as [Cygwin](http://www.cygwin.com/). -- THIS IS UNTESTED

You may also need to install Vagrant VBGuest Plugin

For vagrant < 1.1.5:
* `vagrant gem install vagrant-vbguest`

For vagrant 1.1.5+ (thanks Lars Haugseth):
* `vagrant plugin install vagrant-vbguest`

Issues with Guest Addition not found on virtual: (replace 4.3.22 with correct version you are running)

On GUEST (VM):
* `vagrant ssh`
* `sudo ln -s /opt/VBoxGuestAdditions-4.3.22/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions`

On HOST (LOCAL):
* `vagrant reload`

Sometimes Vagrant requires you to use sudo on the host, here's the fix:

* `chown -R <USERNAME> /<YOUR-WEBSITES-DIRECTORY>/.vagrant`
* `chown -R <USERNAME> /<YOUR-HOME-DIRECTORY>/.vagrant.d`




