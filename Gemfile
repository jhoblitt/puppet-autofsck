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
gem 'rspec-puppet',
  :git => 'https://github.com/joshcooper/rspec-puppet.git',
  :ref => '311ac19d9925767f375df2d0ee411c38ca4f9483',
  :require => false
# rspec 3 spews warnings with rspec-puppet 1.0.1
gem 'rspec-core', '~> 2.0',    :require => false
# see https://github.com/domcleal/rspec-puppet-augeas/issues/9
# rspec-puppet-augeas requires rspec-puppet < 1
gem 'rspec-puppet-augeas',
  :git => 'https://github.com/jhoblitt/rspec-puppet-augeas.git',
  :ref => '6152e283a65f96188dded35be30f6e0540208594',
  :require => false
gem 'ruby-augeas',             :require => false

# vim:ft=ruby
