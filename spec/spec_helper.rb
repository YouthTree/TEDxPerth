ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f }

Remarkable.include_matchers! Remarkable::ActiveModel,  Rspec::Core::ExampleGroup
Remarkable.include_matchers! Remarkable::ActiveRecord, Rspec::Core::ExampleGroup

RSpec.configure do |config|
  config.before(:each) { Machinist.reset_before_test }
  config.mock_with :rr
  config.fixture_path               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
end
