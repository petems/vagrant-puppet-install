# vagrant-puppet-install

[![Gem Version](https://badge.fury.io/rb/vagrant-puppet-install.png)](http://badge.fury.io/rb/vagrant-puppet-install)
[![Build Status](https://travis-ci.org/petems/vagrant-puppet-install.png?branch=master)](https://travis-ci.org/petems/vagrant-puppet-install)
[![Dependency Status](https://gemnasium.com/petems/vagrant-puppet-install.png)](https://gemnasium.com/petems/vagrant-puppet-install)
[![Code Climate](https://codeclimate.com/github/petems/vagrant-puppet-install.png)](https://codeclimate.com/petems/patcon/vagrant-puppet-install)

A Vagrant plugin that ensures the desired version of Puppet is installed via the
Puppet Labs package repo. This proves very useful when using Vagrant
with provisioner-less baseboxes OR cloud images.

This plugin has been verified to work with the following
[Vagrant providers](http://docs.vagrantup.com/v2/providers/index.html):

* VirtualBox (part of core)
* AWS (ships in [vagrant-aws](https://github.com/mitchellh/vagrant-aws) plugin)
* Rackspace (ships in [vagrant-rackspace](https://github.com/mitchellh/vagrant-rackspace) plugin)
* DigitalOcean (ships in [vagrant-digital_ocean](https://github.com/smdahlen/vagrant-digitalocean) plugin)

It may work with other Vagrant providers but is not guaranteed to!

## Installation

Ensure you have downloaded and installed Vagrant 1.1.x from the
[Vagrant downloads page](http://downloads.vagrantup.com/).

Installation is performed in the prescribed manner for Vagrant 1.1 plugins.

```
$ vagrant plugin install vagrant-puppet-install
```

## Usage

The Puppet Install Vagrant plugin automatically hooks into the Vagrant provisioning
middleware. You specify the version of the `puppet-common` package you want
installed using the `puppet_install.version` config key. The version string
should be a valid Puppet release (ie. `2.7.11`, `3.0.*`, etc.).

Install the latest version of Puppet:

```ruby
Vagrant.configure("2") do |config|

  config.puppet_install.version = "*"

  ...

end
```

Install a specific version of Puppet:

```ruby
Vagrant.configure("2") do |config|

  config.puppet_install.version = "2.7.11"

  ...

end
```

## Tests

### Unit

The unit tests can be run with:

```
bundle exec rake
#or
bundle exec rake test:unit
```

The test are also executed by Travis CI every time code is pushed to GitHub.

### Acceptance

The acceptance tests will be run against the Vagrant providers mentioned above. 

The acceptance tests can be run with:

```
# to run them all 
rake test:acceptance
# or specify a provider
rake test:acceptance['virtualbox']
```

And as expected, all acceptance tests only uses provisioner-less baseboxes and
cloud images!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

Patrick Connolly
Martin Lazarov
Peter Souter

### Adapted from original code by

Seth Chisamore
