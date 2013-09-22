require 'spec_helper'

describe 'autofsck', :type => :class do
  let(:facts) {{:osfamily=> 'RedHat'}}

  shared_examples 'generic' do |state|
    it do
      should include_class('autofsck')
      should contain_file('/etc/sysconfig/autofsck').with({
        'ensure' => state,
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    end
    it "/etc/sysconfig/autofsck should contain correct contents" do
      verify_contents(subject, '/etc/sysconfig/autofsck', [
        'AUTOFSCK_DEF_CHECK="yes"',
        'AUTOFSCK_OPT="-y"',
      ])
    end
  end

  describe 'default params' do
    it_behaves_like 'generic', 'present'
  end

  describe 'with ensure => present' do
    let(:params) { {:ensure => 'present'} }

    it_behaves_like 'generic', 'present'
  end

  describe 'with ensure => absent' do
    let(:params) { {:ensure => 'absent'} }

    it_behaves_like 'generic', 'absent'
  end

  describe 'with ensure => foo' do
    let(:params) { {:ensure => 'foo'} }
 
    it do
      expect {
        should include_class('autofsck') 
      }.to raise_error(Puppet::Error, /^validate_re\(\)/)
    end
  end

  # fail on unsupported osfamily
  describe 'unsupported osfamily' do
    let(:facts) { {:osfamily=> 'Debian'} }
 
    it do
      expect {
        should include_class('autofsck') 
      }.to raise_error(Puppet::Error, /^Module autofsck is not supported on/)
    end
  end

end

