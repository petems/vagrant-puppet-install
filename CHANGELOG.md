# Change Log

## [v4.0.1](https://github.com/petems/vagrant-puppet-install/tree/v4.0.1) (2016-04-04)

[Full Changelog](https://github.com/petems/vagrant-puppet-install/compare/v4.0.0...v4.0.1)

**Closed issues:**

- Machine is force to shutdown and destroyed after puppet is installed [\#42](https://github.com/petems/vagrant-puppet-install/issues/42)

- How to install the latest available version of puppet? [\#41](https://github.com/petems/vagrant-puppet-install/issues/41)

**Merged pull requests:**

- Adds acceptance test for Fedora 23 [\#47](https://github.com/petems/vagrant-puppet-install/pull/47) ([petems](https://github.com/petems))

- Fixes Vagrant on Puppet \> 4 for acceptance [\#45](https://github.com/petems/vagrant-puppet-install/pull/45) ([petems](https://github.com/petems))

- Rubocop fixes [\#44](https://github.com/petems/vagrant-puppet-install/pull/44) ([petems](https://github.com/petems))

- Fixes unlink code to work on Windows machines [\#43](https://github.com/petems/vagrant-puppet-install/pull/43) ([petems](https://github.com/petems))

## [v4.0.0](https://github.com/petems/vagrant-puppet-install/tree/v4.0.0) (2016-01-25)

[Full Changelog](https://github.com/petems/vagrant-puppet-install/compare/v3.1.0...v4.0.0)

**Closed issues:**

- Empty puppet\_version gives error. [\#38](https://github.com/petems/vagrant-puppet-install/issues/38)

**Merged pull requests:**

- Removes pessimistic reference from docs [\#40](https://github.com/petems/vagrant-puppet-install/pull/40) ([petems](https://github.com/petems))

- Fix nil errors [\#39](https://github.com/petems/vagrant-puppet-install/pull/39) ([petems](https://github.com/petems))

## [v3.1.0](https://github.com/petems/vagrant-puppet-install/tree/v3.1.0) (2016-01-21)

[Full Changelog](https://github.com/petems/vagrant-puppet-install/compare/v3.0.0...v3.1.0)

**Closed issues:**

- rake beaker errors with vagrant-puppet-install loaded [\#35](https://github.com/petems/vagrant-puppet-install/issues/35)

- apt repo issue \(no puppet-agent found\) trying to install puppet 4.3.1 [\#32](https://github.com/petems/vagrant-puppet-install/issues/32)

- The package is just called puppet-agent [\#31](https://github.com/petems/vagrant-puppet-install/issues/31)

- Vagrant Puppet Install does not work on Puppet \>= 4 [\#29](https://github.com/petems/vagrant-puppet-install/issues/29)

- Cannot install 'vagrant-puppet-install' on Windows 7 [\#25](https://github.com/petems/vagrant-puppet-install/issues/25)

- Allow installing Facter [\#17](https://github.com/petems/vagrant-puppet-install/issues/17)

**Merged pull requests:**

- Don't do anything with puppet\_version is not set. [\#36](https://github.com/petems/vagrant-puppet-install/pull/36) ([glenjamin](https://github.com/glenjamin))

- .idea folder exclude \(all jetbrains IDEs\). [\#34](https://github.com/petems/vagrant-puppet-install/pull/34) ([MikeCaspar](https://github.com/MikeCaspar))

- Add a new Vagrant box to test Ubuntu machines [\#33](https://github.com/petems/vagrant-puppet-install/pull/33) ([petems](https://github.com/petems))

## [v3.0.0](https://github.com/petems/vagrant-puppet-install/tree/v3.0.0) (2015-12-15)

[Full Changelog](https://github.com/petems/vagrant-puppet-install/compare/v2.7.0...v3.0.0)

**Closed issues:**

- pessimistic version constraint [\#26](https://github.com/petems/vagrant-puppet-install/issues/26)

- 2.7.\* is not a valid version of puppet [\#23](https://github.com/petems/vagrant-puppet-install/issues/23)

- Puppet installation@Centos7.0@Parallels10.1.1@OS X 10.10.1 cannot find the rpm file [\#20](https://github.com/petems/vagrant-puppet-install/issues/20)

- Fails on Utopic Unicorn [\#16](https://github.com/petems/vagrant-puppet-install/issues/16)

- https://raw2.github.com/petems/puppet-install-shell/master/install\_puppet.sh Not found [\#15](https://github.com/petems/vagrant-puppet-install/issues/15)

- Works on CentOS with VMware Fusion [\#8](https://github.com/petems/vagrant-puppet-install/issues/8)

- Doesn't work on Ubuntu 12.04 Baseboxes :-\( [\#6](https://github.com/petems/vagrant-puppet-install/issues/6)

**Merged pull requests:**

- Fix to allow Puppet 4 install [\#30](https://github.com/petems/vagrant-puppet-install/pull/30) ([petems](https://github.com/petems))

- Corrects \#26 pessimistic version constraint and passes unit tests [\#28](https://github.com/petems/vagrant-puppet-install/pull/28) ([srhopkins](https://github.com/srhopkins))

- Adds spec to check using ~\> resolution for version [\#24](https://github.com/petems/vagrant-puppet-install/pull/24) ([petems](https://github.com/petems))

- New test for \#6 [\#22](https://github.com/petems/vagrant-puppet-install/pull/22) ([petems](https://github.com/petems))

- Add plugin spec [\#19](https://github.com/petems/vagrant-puppet-install/pull/19) ([petems](https://github.com/petems))

- Bump Vagrant to v1.7.0 [\#18](https://github.com/petems/vagrant-puppet-install/pull/18) ([scottsuch](https://github.com/scottsuch))

- Make badges pretty [\#12](https://github.com/petems/vagrant-puppet-install/pull/12) ([scottsuch](https://github.com/scottsuch))

- All puppet\_version are passed to retrieve\_latest\_puppet\_version [\#27](https://github.com/petems/vagrant-puppet-install/pull/27) ([srhopkins](https://github.com/srhopkins))

## [v2.7.0](https://github.com/petems/vagrant-puppet-install/tree/v2.7.0) (2014-11-21)

[Full Changelog](https://github.com/petems/vagrant-puppet-install/compare/v2.6.0...v2.7.0)

**Closed issues:**

- Github url for puppet-install-shell has changed [\#10](https://github.com/petems/vagrant-puppet-install/issues/10)

**Merged pull requests:**

- Close \#10 Updates location for installer script [\#14](https://github.com/petems/vagrant-puppet-install/pull/14) ([petems](https://github.com/petems))

- Need Vagrant to be ok with bundler 1.7 [\#13](https://github.com/petems/vagrant-puppet-install/pull/13) ([petems](https://github.com/petems))

- Close \#10 [\#11](https://github.com/petems/vagrant-puppet-install/pull/11) ([scottsuch](https://github.com/scottsuch))

## [v2.6.0](https://github.com/petems/vagrant-puppet-install/tree/v2.6.0) (2014-08-04)

[Full Changelog](https://github.com/petems/vagrant-puppet-install/compare/v2.5.0...v2.6.0)

**Closed issues:**

- Plugin should be disabled if `config.puppet\_install.puppet\_version` is not present [\#7](https://github.com/petems/vagrant-puppet-install/issues/7)

- Does not work on CentOS 32-bit BaseBox [\#5](https://github.com/petems/vagrant-puppet-install/issues/5)

## [v2.5.0](https://github.com/petems/vagrant-puppet-install/tree/v2.5.0) (2014-08-03)

**Closed issues:**

- "Not a valid version of Puppet" error [\#3](https://github.com/petems/vagrant-puppet-install/issues/3)

- 1.4 / 1.5 vagrant compatibility [\#1](https://github.com/petems/vagrant-puppet-install/issues/1)

**Merged pull requests:**

- Install url tests and readme [\#4](https://github.com/petems/vagrant-puppet-install/pull/4) ([petems](https://github.com/petems))

- Pulling from omnibus [\#2](https://github.com/petems/vagrant-puppet-install/pull/2) ([petems](https://github.com/petems))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*