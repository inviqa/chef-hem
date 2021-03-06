#
# Cookbook Name:: hem
# Spec:: default
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

describe 'hem::default' do
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:vagrant_sha256sum).and_return('test')
  end

  shared_examples 'default behaviour' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes git' do
      expect(chef_run).to include_recipe('git')
    end

    it 'includes vagrant' do
      expect(chef_run).to include_recipe('vagrant')
    end

    it 'installs the hem package' do
      expect(chef_run).to install_package('hem')
    end
  end

  shared_examples 'rhel repo' do
    it 'does not include apt' do
      expect(chef_run).to_not include_recipe('apt')
    end

    it 'does not set up the hem apt repo' do
      expect(chef_run).to_not add_apt_repository('inviqa-tools')
    end

    it 'sets up the hem yum repo' do
      expect(chef_run).to create_yum_repository('inviqa-tools').with(
        description: 'Inviqa Tools Repository - EL6 $basearch',
        baseurl: 'https://dx6pc3giz7k1r.cloudfront.net/repos/el6/$basearch',
        enabled: true,
        gpgcheck: true,
        gpgkey: 'https://dx6pc3giz7k1r.cloudfront.net/GPG-KEY-inviqa-tools',
        sslverify: true
      )
    end
  end

  context 'When all attributes are default, on centos 6.7' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.7').converge(described_recipe)
    end

    it_behaves_like 'default behaviour'
    it_behaves_like 'rhel repo'
  end

  context 'When all attributes are default, on centos 7.2' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511').converge(described_recipe)
    end

    it_behaves_like 'default behaviour'
    it_behaves_like 'rhel repo'
  end

  context 'When all attributes are default, on ubuntu 14.04' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe)
    end

    it_behaves_like 'default behaviour'

    it 'includes apt' do
      expect(chef_run).to include_recipe('apt')
    end

    it 'does not set up the hem yum repo' do
      expect(chef_run).to_not create_yum_repository('inviqa-tools')
    end

    it 'sets up the hem repo' do
      expect(chef_run).to add_apt_repository('inviqa-tools').with(
        uri: 'https://dx6pc3giz7k1r.cloudfront.net/repos/ubuntu',
        distribution: 'trusty',
        components: ['main'],
        key: 'https://dx6pc3giz7k1r.cloudfront.net/GPG-KEY-inviqa-tools'
      )
    end
  end
end
