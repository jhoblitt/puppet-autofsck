require 'spec_helper'

describe 'autofsck' do
  let(:title) { 'redhat' }
  let(:facts) { {:osfamily=> 'RedHat'} }
  # include autofsck
  context 'default params' do
    it do
      should include_class('autofsck')
      should contain_file('/etc/sysconfig/autofsck').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    end
  end


  # class{ autofsck: ensure => present }
  context 'with ensure => present' do
    let(:params) { {:ensure => 'present'} }

    it do
      should include_class('autofsck')
      should contain_file('/etc/sysconfig/autofsck') 
    end
  end

  # class{ autofsck: ensure => absent }
  context 'with ensure => absent' do
    let(:params) { {:ensure => 'absent'} }

    it do
      should include_class('autofsck')
      should contain_file('/etc/sysconfig/autofsck').with({
        'ensure' => 'absent',
      })
    end
  end

  # invalid arg param
  # class{ autofsck: ensure => foo }
  context 'with ensure => foo' do
    let(:params) { {:ensure => 'foo'} }
 
    it do
      expect {
        should include_class('autofsck') 
      }.to raise_error(Puppet::Error, /^validate_re\(\)/)
    end
  end

  # fail on unsupported osfamily
  context 'unsupported osfamily' do
    let(:facts) { {:osfamily=> 'Debian'} }
 
    it do
      expect {
        should include_class('autofsck') 
      }.to raise_error(Puppet::Error, /^Module autofsck is not supported on/)
    end
  end

end

