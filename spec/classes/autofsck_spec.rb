require 'spec_helper'

describe 'autofsck', :type => :class do
  shared_examples 'redhat' do |state|
    it { should contain_class('autofsck') }
    it do
      should contain_file('/etc/sysconfig/autofsck').with({
        'ensure' => state,
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    end
    it { should_not contain_augeas('fsckfix') }
    it "/etc/sysconfig/autofsck should contain correct contents" do
      verify_contents(subject, '/etc/sysconfig/autofsck', [
        'AUTOFSCK_DEF_CHECK="yes"',
        'AUTOFSCK_OPT="-y"',
      ])
    end
  end

  shared_examples 'debian' do |state|
    it { should contain_class('autofsck') }
    it { should_not contain_file('/etc/sysconfig/autofsck') }
    it { should contain_augeas('fsckfix').with_changes("set FSCKFIX #{state}") }
    describe_augeas 'fsckfix', :lens => 'Shellvars', :target => 'etc/default/rcS' do
      # The example fixture has FSCKFIX=no so we should not see change when
      # augueas is trying to set the current value
      if state == 'yes'
        it 'should change FSCKFIX' do
          should execute.with_change
          aug_get('FSCKFIX').should == state
          should execute.idempotently
        end
      else
        it 'should not change FSCKFIX' do
          should execute
          aug_get('FSCKFIX').should == state
        end
      end
    end
  end

  context 'On RedHat' do
    let(:facts) {{:osfamily=> 'RedHat'}}

    describe 'default params' do
      it_behaves_like 'redhat', 'present'
    end

    describe 'with ensure => present' do
      let(:params) { {:ensure => 'present'} }

      it_behaves_like 'redhat', 'present'
    end

    describe 'with ensure => absent' do
      let(:params) { {:ensure => 'absent'} }

      it_behaves_like 'redhat', 'absent'
    end

    describe 'with ensure => foo' do
      let(:params) { {:ensure => 'foo'} }

      it do
        should raise_error(Puppet::Error, /^validate_re\(\)/)
      end
    end
  end # On RedHat

  context 'On Debian' do
    let(:facts) { {:osfamily=> 'Debian'} }

    describe 'default params' do
      it_behaves_like 'debian', 'yes'
    end

    describe 'with ensure => present' do
      let(:params) { {:ensure => 'present'} }

      it_behaves_like 'debian', 'yes'
    end

    describe 'with ensure => absent' do
      let(:params) { {:ensure => 'absent'} }

      it_behaves_like 'debian', 'no'
    end
  end # On Debian

  # fail on unsupported osfamily
  describe 'unsupported osfamily' do
    let(:facts) { {:osfamily=> 'Freebsd'} }

    it do
      should raise_error(Puppet::Error, /^Module autofsck is not supported on/)
    end
  end

end

