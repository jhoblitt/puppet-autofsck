require 'spec_helper'

describe 'autofsck' do
  let(:title) { 'redhat' }
  let(:facts) { {:osfamily=> 'RedHat'} }

  it { should include_class('autofsck') }

  # include autofsck
  it do
    should contain_file('/etc/sysconfig/autofsck').with({
      'ensure' => 'present',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
    })
  end


  # class{ autofsck: ensure => present }
  context 'with ensure => present' do
    let(:params) { {:ensure => 'present'} }

    it do
      should contain_file('/etc/sysconfig/autofsck') 
    end
  end

#  can't figure out how to test for absess from the catalog.  Neither "should
#  not" or "should !" actually work.
#
#  # class{ autofsck: ensure => absent }
#  context 'with ensure => absent' do
#    let(:params) { {:ensure => 'absent'} }
#
#    it do
#      should contain_file('/etc/sysconfig/autofsck') 
#    end
#  end

  # invalid arg param
  # class{ autofsck: ensure => foo }
  context 'with ensure => foo' do
    let(:params) { {:bar => 'foo'} }

    it do
      expect {
        include_class('autofsck') 
      }.to raise_error(Puppet::ParseError, /invalid parameter/)
    end
  end

  # fail on unsupported osfamily
  context 'unsupported osfamily' do
    let(:facts) { {:osfamily=> 'Debian'} }

    it do
      expect {
        include_class('autofsck') 
      }.to raise_error(Puppet::ParseError, /Module autofsck is not supported on/)
    end
  end

end

