source 'https://rubygems.org'

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

gem 'rake',                    :require => false
gem 'puppetlabs_spec_helper',  :require => false
gem 'puppet-lint',             :require => false
gem 'puppet-syntax',           :require => false
# rspec-puppet > 1 appears to breaks rspec-puppet-augeas 0.2.3
# see https://github.com/domcleal/rspec-puppet-augeas/issues/9
gem 'rspec-puppet', '0.1.6',   :require => false
gem 'rspec-puppet-augeas',     :require => false
gem 'ruby-augeas',             :require => false

# vim:ft=ruby
