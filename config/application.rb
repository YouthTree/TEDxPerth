require File.expand_path('../boot', __FILE__)

require 'rails/all'
Bundler.require(:default, Rails.env) if defined?(Bundler)

module TEDxPerth
  class Application < Rails::Application

    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    config.autoload_paths += %W( #{config.root}/app/mailers #{config.root}/app/observers #{config.root}/lib )
    
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => false
    end
    config.time_zone = Settings.fetch(:time_zone, "UTC")
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
  end
end
