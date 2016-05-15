# Vagrant LEMP Stack for Bedrock

A simple Vagrantfile and bootstrap script that installs a Vagrant box suitable for deploying Wordpress with [Roots.io Bedrock](https://roots.io/bedrock/).

###What's installed?
* PHP 7
* nginx
* MariaDB
* git
* Composer

Put `Vagrantfile` and `bootstrap.sh` inside a folder and do a `vagrant up` on the command line.
This box uses Ubuntu 14.04 LTS "Trustry Thar" 64bit, so if you don't have the basic box already, do a 
`vagrant box add ubuntu/trusty64` before.