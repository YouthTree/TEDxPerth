if ENV['MY_RUBY_HOME'] && ENV['MY_RUBY_HOME'].include?('rvm')
  rvm_path     = File.dirname(File.dirname(ENV['MY_RUBY_HOME']))
  rvm_lib_path = File.join(rvm_path, 'lib')
  # Differentiate between new and old passenger versions
  if File.exist?(File.join(rvm_lib_path, "rvm", "environment.rb"))
    $LOAD_PATH.unshift rvm_lib_path
    require 'rvm'
    RVM.use_from_path! Dir.pwd # Passenger starts in the app root
  end
end

ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
require 'bundler/setup'