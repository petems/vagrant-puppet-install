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
      # This action will extract the installed version of Puppet installed on the
      # guest. The resulting version will exist in the `:installed_puppet_version`
      # key in the environment.
      class ReadPuppetVersion
        def initialize(app, env)
          @app = app
        end

        def call(env)
          env[:installed_puppet_version] = nil
          env[:machine].communicate.tap do |comm|
            # Execute it with sudo
            comm.sudo(puppet_version_command) do |type, data|
              if [:stderr, :stdout].include?(type)
                env[:installed_puppet_version] = data.chomp
              end
            end
          end
          @app.call(env)
        end

        private

        def puppet_version_command
          <<-PUPPET_VERSION
echo $(puppet --version || "")
          PUPPET_VERSION
        end
      end
    end
  end
end
