# vagrant-puppet-install

[![Gem Version](http://img.shields.io/gem/v/vagrant-puppet-install.svg)][gem]
[![Build Status](http://img.shields.io/travis/petems/vagrant-puppet-install.svg)][travis]
[![Dependency Status](http://img.shields.io/gemnasium/petems/vagrant-puppet-install.svg)][gemnasium]
[![Code Climate](http://img.shields.io/codeclimate/github/petems/vagrant-puppet-install.svg)][codeclimate]

[gem]: https://rubygems.org/gems/vagrant-puppet-install
[travis]: http://travis-ci.org/petems/vagrant-puppet-install
[gemnasium]: https://gemnasium.com/petems/vagrant-puppet-install
[codeclimate]: https://codeclimate.com/github/petems/vagrant-puppet-install


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
installed using the `puppet_install.puppet_version` config key. The version string
should be a valid Puppet release (ie. `2.7.11`, `3.7.4`, etc.).

The Puppet version is validated against the RubyGems API, so you can use gem syntax to give a [pessimistic version constraint](http://guides.rubygems.org/patterns/#pessimistic-version-constraint) such as `~> 2.7` which will return the latest version of the 2.7.*.

Install the latest version of Puppet:

```ruby
Vagrant.configure("2") do |config|

  config.puppet_install.puppet_version = :latest

  ...

end
```

Install a specific version of Puppet:

```ruby
Vagrant.configure("2") do |config|

  config.puppet_install.puppet_version = "2.7.11"

  ...

end
```

Specify a custom install script:

```ruby
Vagrant.configure("2") do |config|

  config.puppet_install.install_url = 'http://acme.com/install.sh'
  # config.puppet_install.install_url = 'http://acme.com/install.msi'
  # config.puppet_install.install_url = '/some/path/on/the/host'

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
