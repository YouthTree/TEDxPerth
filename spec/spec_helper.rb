ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rr
  config.fixture_path               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
end
