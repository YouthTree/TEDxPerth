source 'http://rubygems.org'

def gh(user, repo)
  "git://github.com/#{user}/#{repo}.git"
end

# Rails itself.
gem 'rails', '3.0.3'

# Core Dependencies
gem 'json',   '~> 1.4.6'
gem 'mysql2', '~> 0.2.6'
gem 'awesome_print', '0.2.1', :require => nil


# View Related
gem 'haml',                  '~> 3.0.24'
gem 'compass',               '~> 0.10.0'
gem 'compass-colors',        '~> 0.3.1'
gem 'fancy-buttons',         '~> 1.0.4'
gem 'formtastic',            '~> 1.2.1'
gem 'validation_reflection', '~> 1.0.0'
gem 'title_estuary',         '~> 1.2.0'
gem 'show_for',              '~> 0.2.3'
gem 'inherited_resources',   '~> 1.1.2'

# Model Related
gem 'uuid',             '~> 2.3.1'
gem 'stringex',         '~> 1.2.0'
gem 'pseudocephalopod', '~> 0.3.2'
gem 'almost-happy',     '~> 0.3.0'
gem 'will_paginate',    '~> 3.0.pre2', :git => gh('mislav', 'will_paginate'), :branch => 'rails3'
gem 'bcrypt-ruby',      '~> 2.1.2',    :require => 'bcrypt'
gem 'state_machine',    '~> 0.9.0',    :git => gh('pluginaweek', 'state_machine')
gem 'msales-carmen',    '~> 0.1.4',    :require => ['carmen', 'carmen/action_view_helpers']

# Controller Related
gem 'youthtree-settings',       '~>  0.1.4'
gem 'youthtree-controller-ext', '~> 0.1.2'
gem 'bhm-admin',                '~> 0.2.2'

# Javascript
gem 'barista',           '>= 0.7.0.pre2'
gem 'shuriken',          '~> 0.2'
gem 'bhm-google-maps',   '~> 0.3'
gem 'youthtree-js',      '~> 0.2'
gem 'youthtree-helpers', '~> 0.1'


# Misc 
gem 'youthtree-capistrano', :require => nil
gem 'jammit'
gem 'nokogiri'
gem 'mail_form'
gem 'acts_as_indexed'
gem 'geokit'
gem 'RubyInline'
gem 'rmagick'
gem 'carrierwave'

# Auth
gem 'authlogic',     :git => gh('kurbmedia', 'authlogic')
gem 'authlogic_rpx', :git => gh('kuldarkrabbi', 'authlogic_rpx')
gem 'rpx_now'

gem 'validates_url_format_of'

# Bundle it!
gem 'unicorn', :require => nil

group :development do
  gem 'rails3-generators'
  gem 'mongrel'
  gem 'annotate', :git => gh('miyucy', 'annotate_models'), :require => nil
end

group :test, :development do
  gem 'rspec',       '~> 2.1'
  gem 'rspec-rails', '~> 2.1'
  gem 'machinist',   '>= 2.0.0.beta2', :require => nil
  gem 'forgery',                       :require => nil
end

group :test do
  gem 'ZenTest'
  gem 'remarkable',              '>= 4.0.0.alpah4', :require => 'remarkable/core'
  gem 'remarkable_activerecord', '>= 4.0.0.alpah4', :require => 'remarkable/active_record'
  gem 'rr'
end

group :test_mac do
  gem 'autotest-growl'
  gem 'autotest-fsevent'
end

group :staging, :production do
  gem 'hoptoad_notifier'
end
