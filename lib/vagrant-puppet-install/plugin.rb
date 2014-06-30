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

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < '1.1.0'
  fail 'The Vagrant Puppet Install plugin is only compatible with Vagrant 1.1+'
end

module VagrantPlugins
  #
  module PuppetInstall
    # @author Seth Chisamore <schisamo@opscode.com>
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
