#
# Copyright (c) 2013, Seth Chisamore
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module VagrantPlugins
  module PuppetInstall
    module Action
      # @author Seth Chisamore <schisamo@opscode.com>
      #
      # This action installs Puppet packages at the desired version.
      class InstallPuppet

        ubuntu_codename = %x[lsb_release --codename | awk '{ print $2 }'].chomp
        APT_PACKAGE_FILE = "puppetlabs-release-lucid.deb"
        APT_PACKAGE_FILE_URL = "http://apt.puppetlabs.com/#{APT_PACKAGE_FILE}".freeze

        def initialize(app, env)
          @app = app
          # Config#finalize! SHOULD be called automatically
          env[:global_config].puppet_install.finalize!
        end

        def call(env)
          desired_puppet_version = env[:global_config].puppet_install.version

          unless desired_puppet_version.nil?
            env[:ui].info("Ensuring Puppet is installed at requested version of #{desired_puppet_version}.")
            if env[:installed_puppet_version] == desired_puppet_version
              env[:ui].info("Puppet #{desired_puppet_version} package is already installed...skipping installation.")
            else
              env[:ui].info("Puppet #{desired_puppet_version} package is not installed...installing now.")
              env[:ssh_run_command] = install_puppet_command(desired_puppet_version)
            end
          end

          @app.call(env)
        end

        private

        def install_puppet_command(version='*')
          <<-INSTALL_PUPPET
cd /tmp
if command -v wget &>/dev/null; then
  wget --quiet #{APT_PACKAGE_FILE_URL}
elif command -v curl &>/dev/null; then
  curl --location --remote-name #{APT_PACKAGE_FILE_URL}
else
  echo "Neither wget nor curl found. Please install one and try again." >&2
  exit 1
fi
sudo dpkg --install #{APT_PACKAGE_FILE}
sudo apt-get update --quiet
sudo apt-get install puppet-common=#{version}* -y
INSTALL_PUPPET
        end
      end
    end
  end
end
