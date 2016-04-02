require 'rubygems/dependency'
require 'rubygems/dependency_installer'
require 'vagrant'

module VagrantPlugins
  module PuppetInstall
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :puppet_version, :install_url

      def initialize
        @puppet_version = UNSET_VALUE
        @install_url = UNSET_VALUE
        @logger = Log4r::Logger.new('vagrantplugins::puppet_install::config')
      end

      def finalize!
        if @puppet_version == UNSET_VALUE
          @puppet_version = nil
        elsif @puppet_version.to_s == 'latest'
          # resolve `latest` to a real version
          @puppet_version = retrieve_latest_puppet_version
        end
        @install_url = nil if @install_url == UNSET_VALUE
      end

      def validate!(_machine)
        finalize!
        errors = []

        if !puppet_version.nil? && !valid_puppet_version?(puppet_version)
          msg = <<-EOH
'#{puppet_version}' is not a valid version of Puppet.

A list of valid versions can be found at: http://docs.puppetlabs.com/release_notes/
          EOH
          errors << msg
        end

        if errors.any?
          rendered_errors = Vagrant::Util::TemplateRenderer.render(
            'config/validation_failed',
            errors: { 'vagrant-puppet-install' => errors }
          )
          raise Vagrant::Errors::ConfigInvalid, errors: rendered_errors
        end
      end

      private

      # Query RubyGems.org's Ruby API and retrive the latest version of Puppet.
      def retrieve_latest_puppet_version
        available_gems =
          dependency_installer.find_gems_with_sources(puppet_gem_dependency)
        spec, _source =
          if available_gems.respond_to?(:last)
            # DependencyInstaller sorts the results such that the last one is
            # always the one it considers best.
            spec_with_source = available_gems.last
            spec_with_source
          else
            # Rubygems 2.0 returns a Gem::Available set, which is a
            # collection of AvailableSet::Tuple structs
            available_gems.pick_best!
            best_gem = available_gems.set.first
            best_gem && [best_gem.spec, best_gem.source]
          end

        spec && spec.version.to_s
      end

      # Query RubyGems.org's Ruby API to see if the user-provided Puppet version
      # is in fact a real Puppet version!
      def valid_puppet_version?(version)
        is_valid = false
        begin
          available = dependency_installer.find_gems_with_sources(
            puppet_gem_dependency(version)
          )
          is_valid = true unless available.empty?
        rescue ArgumentError => e
          @logger.debug("#{version} is not a valid Puppet version: #{e}")
        end
        is_valid
      end

      def dependency_installer
        @dependency_installer ||= Gem::DependencyInstaller.new
      end

      def puppet_gem_dependency(version = nil)
        Gem::Dependency.new('puppet', version)
      end
    end
  end
end
