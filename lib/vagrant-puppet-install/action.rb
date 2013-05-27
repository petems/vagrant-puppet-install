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

require "vagrant/action/builder"

module VagrantPlugins
  module PuppetInstall
    module Action
      autoload :InstallPuppet, File.expand_path("../action/install_puppet", __FILE__)
      autoload :IsRunningOrActive, File.expand_path("../action/is_running_or_active", __FILE__)
      autoload :ReadPuppetVersion, File.expand_path("../action/read_puppet_version", __FILE__)

      # Include the built-in modules so that we can use them as top-level
      # things.
      include Vagrant::Action::Builtin

      # @return [::Vagrant::Action::Builder]
      def self.install_puppet
        @install_puppet ||= ::Vagrant::Action::Builder.new.tap do |b|
          b.use ConfigValidate
          b.use Call, IsRunningOrActive do |env1, b2|
            if env1[:result]
              b2.use ReadPuppetVersion
              b2.use InstallPuppet
              b2.use SSHRun
            end
          end
        end
      end
    end
  end
end
