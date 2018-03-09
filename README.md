# Vagrant LEMP Stack for Bedrock

A simple Vagrantfile and bootstrap script that installs a Vagrant box suitable for deploying Wordpress with [Roots.io Bedrock](https://roots.io/bedrock/).

### What's installed?
* Ubuntu 16.04
* nginx
* MySQL 5.7
* PHP 7.2
* git
* Composer

### How to use?

Use `vagrant box add ubuntu/xenial64` to download and install vagrant image.

Edit `bootstrap.sh` to include your desired database name and password. Database user will be `root`.

Put `Vagrantfile` and `bootstrap.sh` inside a folder and do a `vagrant up` on the command line.

Once Vagrant is provisioned, your new vagrant box will be running at IP `192.168.33.22`. You may want to add this to your hosts file.