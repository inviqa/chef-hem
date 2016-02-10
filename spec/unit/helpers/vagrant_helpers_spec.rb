require 'spec_helper'
require_relative '../../../libraries/vagrant_helpers'

describe 'vagrant uri' do
  before do
    allow_any_instance_of(Kernel).to receive(:vagrant_platform_package).and_return('vagrant_1.8.1_x86_64.rpm')
    allow_any_instance_of(Kernel).to receive(:open)
      .with('https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_SHA256SUMS?direct')
      .and_return(
        Class.new do
          def readlines
            [
              '2cfdbeec9e40376e49dae9d9f27511896e3b296f0e24f8731339bb3d32c48c93  vagrant_1.8.1.dmg',
              '6468cc140f6f236c3ac4bc0bbb1cc2177114249bc344e0aba8c826eae9cc6eb2  vagrant_1.8.1.msi',
              'ae93af8cacf20f2f8c4c6a111767e77988454d0238a001a37a1d1c115334efdb  vagrant_1.8.1_i686.deb',
              '8a5773f52039addea0830efea18f127dcdff7f649699bbce3672c43da1e51a92  vagrant_1.8.1_i686.rpm',
              'ed0e1ae0f35aecd47e0b3dfb486a230984a08ceda3b371486add4d42714a693d  vagrant_1.8.1_x86_64.deb',
              'd2b2308cb1a7da656f6f7cd926287cd21f3c79bf29bc15f09d7471a93f1ef118  vagrant_1.8.1_x86_64.rpm'
            ]
          end
        end.new
      )
  end

  it 'returns the correct vagrant package url' do
    expect(vagrant_package_uri('1.8.1')).to eq('https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.rpm')
  end

  it 'calls out to the right url for checksums' do
    expect_any_instance_of(Kernel).to receive(:open)
      .with('https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_SHA256SUMS?direct')
    vagrant_sha256sum('1.8.1')
  end

  it 'returns the correct vagrant shasum' do
    expect(vagrant_sha256sum('1.8.1')).to eq('d2b2308cb1a7da656f6f7cd926287cd21f3c79bf29bc15f09d7471a93f1ef118')
  end
end
