module VagrantPlugins
  module PuppetInstall
    class Plugin < Vagrant.plugin('2')
      name 'vagrant-puppet-install'
      description <<-DESC
      This plugin ensures the desired version of Puppet is installed
      via the Puppet Labs package repos.
      DESC

      VAGRANT_VERSION_REQUIREMENT = '>= 1.1.0'

      # Returns true if the Vagrant version fulfills the requirements
      #
      # @param requirements [String, Array<String>] the version requirement
      # @return [Boolean]
      def self.check_vagrant_version(*requirements)
        Gem::Requirement.new(*requirements).satisfied_by?(
          Gem::Version.new(Vagrant::VERSION))
      end

      # Verifies that the Vagrant version fulfills the requirements
      #
      # @raise [VagrantPlugins::ProxyConf::VagrantVersionError] if this plugin
      # is incompatible with the Vagrant version
      def self.check_vagrant_version!
        unless check_vagrant_version(VAGRANT_VERSION_REQUIREMENT)
          msg = I18n.t(
            'vagrant-puppet_install.errors.vagrant_version',
            requirement: VAGRANT_VERSION_REQUIREMENT.inspect)
          $stderr.puts msg
          fail msg
        end
      end

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
