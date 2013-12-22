require 'spec_helper'

describe 'autofsck', :type => :class do
  let(:facts) {{:osfamily=> 'RedHat'}}

  shared_examples 'generic' do |state|
    it do
      should contain_class('autofsck')
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
        should contain_class('autofsck')
      }.to raise_error(Puppet::Error, /^validate_re\(\)/)
    end
  end

  context 'On Debian' do
    describe 'With ensure => present' do
      let(:facts) { {:osfamily=> 'Debian'} }
      let(:params) { {:ensure => 'present'} }
      it { should_not contain_file('/etc/sysconfig/autofsck') }
      it { should contain_augeas('fsckfix').\
        with_changes('set FSCKFIX yes')
      }
    end
    describe 'With ensure => absent' do
      let(:facts) { {:osfamily=> 'Debian'} }
      let(:params) { {:ensure => 'absent'} }
      it { should_not contain_file('/etc/sysconfig/autofsck') }
      it { should contain_augeas('fsckfix').\
        with_changes('set FSCKFIX no')
      }
    end
  end

  # fail on unsupported osfamily
  describe 'unsupported osfamily' do
    let(:facts) { {:osfamily=> 'Freebsd'} }
 
    it do
      expect {
        should contain_class('autofsck')
      }.to raise_error(Puppet::Error, /^Module autofsck is not supported on/)
    end
  end

end

