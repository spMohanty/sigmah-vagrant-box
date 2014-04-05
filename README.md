sigmah-vagrant-box
================

Build the Vagrant box set to setup the Sigmah Developers Environment

## Installation

* If you haven't already, go over to [http://www.vagrantup.com/](http://www.vagrantup.com/) and follow the installation instructions
* Add the box `precise64` via `vagrant box add precise64 http://files.vagrantup.com/precise64.box`
* Clone this repo `git clone https://github.com/spMohanty/sigmah-vagrant-box.git`
* Init the submodules `git submodule update --init`
* `mkdir puppet/modules/maven/files`
* Download the Maven archive `apache-maven-3.1.1-bin.tar.gz` from [http://maven.apache.org](http://maven.apache.org) to `puppet/modules/maven/files` directory
* All done; `vagrant up`

## Usage

Feel free to customise further or use as is.

The directory `webapp` is sync'd to `/vagrant` so place your code in there and hack away.

Ports 8080 and 5432 are mapped to their respective ports on the VM.

Jump onto the VM by `vagrant ssh`.

Test it out with `mvn -v` or `psql -h localhost -U postgres`.

You may want to edit Postgres config in the `puppet/manifests/base.pp` file.


## Installed modules

All as git submodules unless otherwise stated. Also not listing dependancies, only major modules.

* [Java](https://github.com/puppetlabs/puppetlabs-java)
* [Postgresql](https://github.com/puppetlabs/puppet-postgresql)
* [Maven](https://github.com/7terminals/puppet-maven)

## Changelog

#### 5th April, 2014
Forked the intial Vagrant Box set for setting up the Java Decelopment Env from https://github.com/rob-murray/vagrant-javadev-box


## Contributions

Please use the GitHub pull-request mechanism to submit contributions.
