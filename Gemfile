source 'http://rubygems.org'

gem 'rails', '3.0.0.rc'

gem 'json'
gem 'mysql'


# View Related

gem 'haml',                  '>= 3.0.13'
gem 'compass',               '>= 0.10.2'
gem 'compass-colors',        '>= 0.3.1'
gem 'fancy-buttons',         '>= 0.5.4'
gem 'formtastic',            '>= 1.0.0.beta'
gem 'validation_reflection', '>= 0.3.6', :git => "git://github.com/Sutto/validation_reflection.git"
gem 'title_estuary',         '>= 1.2.0'
gem 'show_for'
gem 'inherited_resources'

# Model Related

gem 'uuid'
gem 'stringex'
gem 'pseudocephalopod', '>= 0.2.4'
gem 'almost-happy',     '>= 0.3.0'
gem 'will_paginate',    '>= 3.0.pre', :git => 'git://github.com/mislav/will_paginate.git', :branch => 'rails3'
gem 'bcrypt-ruby',      '>= 2.1.2', :require => 'bcrypt'
gem 'state_machine',    '>= 0.9.0'
gem 'msales-carmen',    '>= 0.1.4', :require => ['carmen', 'carmen/action_view_helpers']

gem 'awesome_print'

# Controller Related

gem 'youthtree-settings', '>= 0.1.1'
gem 'youthtree-controller-ext'
gem 'bhm-admin', '>= 0.2.0'

# Javascript
gem 'barista', '>= 0.5.0'
gem 'shuriken'
gem 'bhm-google-maps'
gem 'youthtree-js'

gem 'jammit'

gem 'nokogiri'

gem 'mail_form'

gem 'acts_as_indexed'

gem 'geokit'

# Auth
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem 'authlogic_rpx', :git => 'git://github.com/tardate/authlogic_rpx.git'
gem 'rpx_now'

gem 'validates_url_format_of'

group :development do
  gem 'rails3-generators'
  gem 'mongrel'
  gem 'barista_growl'
  gem 'annotate', :git => 'git://github.com/miyucy/annotate_models.git'
end

group :test, :development do
  gem 'rspec',       '>= 2.0.0.beta.16'
  gem 'rspec-rails', '>= 2.0.0.beta.16'
  gem 'machinist',   '>= 2.0.0.beta2', :require => nil
  gem 'forgery',                       :require => nil
end

group :test do
  gem 'ZenTest'
  if `uname`.strip =~ /darwin/
    gem 'autotest-growl'
    gem 'autotest-fsevent'
  end
  gem 'remarkable', '>= 4.0.0.alpah4', :require => 'remarkable/core'
  gem 'remarkable_activerecord', '>= 4.0.0.alpah4', :require => 'remarkable/active_record'
  gem 'rr'
end