require 'log4r'
require 'shellwords'

require 'vagrant/util/downloader'

module VagrantPlugins
  module PuppetInstall
    module Action
      # @author Seth Chisamore <schisamo@opscode.com>
      #
      # This action installs Puppet packages at the desired version.
      class InstallPuppet

        def initialize(app, env)
          @app = app
          @logger =
            Log4r::Logger.new('vagrantplugins::puppet_install::action::installpuppet')
          @machine = env[:machine]
          @install_script = find_install_script
          @machine.config.puppet_install.finalize!
        end

        def call(env)
          @app.call(env)

          return unless @machine.communicate.ready? && provision_enabled?(env)

          desired_version = @machine.config.puppet_install.puppet_version
          unless desired_version.nil?
            if installed_version == desired_version
              env[:ui].info I18n.t(
                'vagrant-puppet_install.action.installed',
                version: desired_version
              )
            else
              fetch_or_create_install_script(env)
              env[:ui].info I18n.t(
                'vagrant-puppet_install.action.installing',
                version: desired_version
              )
              install(desired_version, env)
              recover(env)
            end
          end
        end

        private

        # Determines what flavor of install script should be used
        def find_install_script
          if !ENV['PUPPET_INSTALL_URL'].nil?
            ENV['PUPPET_INSTALL_URL']
          elsif windows_guest?
            #
          else
            'https://raw2.github.com/petems/puppet-install-shell/master/install_puppet.sh'
          end
        end

        def install_script_name
          if windows_guest?
            #
          else
            'install.sh'
          end
        end

        def windows_guest?
          @machine.config.vm.guest.eql?(:windows)
        end

        def provision_enabled?(env)
          env.fetch(:provision_enabled, true)
        end

        def installed_version
          version = nil
          opts = nil
          if windows_guest?
            # Not sure how to do this yet...
          else
            command = 'echo $(puppet --version)'
          end
          @machine.communicate.sudo(command, opts) do |type, data|
            if [:stderr, :stdout].include?(type)
              version_match = data.match(/^(.+)/)
              version = version_match.captures[0].strip if version_match
            end
          end
          version
        end

        #
        # Upload install script from Host's Vagrant TMP directory to guest
        # and executes.
        #
        def install(version, env)
          shell_escaped_version = Shellwords.escape(version)

          @machine.communicate.tap do |comm|
            comm.upload(@script_tmp_path, install_script_name)
            if windows_guest?
              # Not sure yet...
            else
              # TODO: Execute with `sh` once install.sh removes it's bash-isms.
              install_cmd =
                "bash #{install_script_name} -v #{shell_escaped_version} 2>&1"
            end
            comm.sudo(install_cmd) do |type, data|
              if [:stderr, :stdout].include?(type)
                next if data =~ /stdin: is not a tty/
                env[:ui].info(data)
              end
            end
          end
        end

        #
        # Fetches or creates a platform specific install script to the Host's
        # Vagrant TMP directory.
        #
        def fetch_or_create_install_script(env)
          @script_tmp_path =
            env[:tmp_path].join("#{Time.now.to_i.to_s}-#{install_script_name}")

          @logger.info("Generating install script at: #{@script_tmp_path}")

          url = @install_script

          if File.file?(url) || url !~ /^[a-z0-9]+:.*$/i
            @logger.info('Assuming URL is a file.')
            file_path = File.expand_path(url)
            file_path = Vagrant::Util::Platform.cygwin_windows_path(file_path)
            url = "file:#{file_path}"
          end

          # Download the install.sh or create install.bat file to a temporary
          # path. We store the temporary path as an instance variable so that
          # the `#recover` method can access it.
          begin
            if windows_guest?
              # Not sure how to do this in Windows yet...
            else
              downloader = Vagrant::Util::Downloader.new(
                url,
                @script_tmp_path,
                {}
              )
              downloader.download!
            end
          rescue Vagrant::Errors::DownloaderInterrupted
            # The downloader was interrupted, so just return, because that
            # means we were interrupted as well.
            env[:ui].info(I18n.t('vagrant-puppet_install.download.interrupted'))
            return
          end
        end

        def recover(env)
          if @script_tmp_path && File.exist?(@script_tmp_path)
            File.unlink(@script_tmp_path)
          end
        end
      end
    end
  end
end
