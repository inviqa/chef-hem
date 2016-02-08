#
# Cookbook Name:: hem
# Spec:: environment
#
# Copyright 2016 Inviqa UK Ltd
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

require 'spec_helper'

describe 'hem::environment' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a profile script' do
      expect(chef_run).to create_template('/etc/profile.d/zzz_hem.sh').with(
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end

    it 'sets up hem to run in local mode' do
      expect(chef_run).to render_file('/etc/profile.d/zzz_hem.sh')
        .with_content('export HEM_RUN_ENV="local"')
    end

    it 'sets up hem to be at the end of the path' do
      expect(chef_run).to render_file('/etc/profile.d/zzz_hem.sh')
        .with_content('export PATH="$PATH:/opt/hem/bin:/opt/hem/embedded/bin"')
    end
  end
end
