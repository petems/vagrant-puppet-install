if Vagrant::VERSION < '1.1.0'
  fail 'The Vagrant Puppet Install plugin is only compatible with Vagrant 1.1+'
end

module VagrantPlugins
  module PuppetInstall
    class Plugin < Vagrant.plugin('2')
      name 'vagrant-puppet-install'
      description <<-DESC
      This plugin ensures the desired version of Puppet is installed
      via the Puppet Labs package repos.
      DESC

      action_hook(:install_puppet, Plugin::ALL_ACTIONS) do |hook|
        require_relative 'action/install_puppet'
        hook.after(Vagrant::Action::Builtin::Provision, Action::InstallPuppet)

        # The AWS provider < v0.4.0 uses a non-standard Provision action
        # on initial creation:
        #
        # mitchellh/vagrant-aws/blob/v0.3.0/lib/vagrant-aws/action.rb#L105
        #
        if defined? VagrantPlugins::AWS::Action::TimedProvision
          hook.after(VagrantPlugins::AWS::Action::TimedProvision,
                     Action::InstallPuppet)
        end
      end

      config(:puppet_install) do
        require_relative 'config'
        Config
      end
    end
  end
end
