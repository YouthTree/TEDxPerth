# Configure barista.
Barista.configure do |config|

  config.root    = Rails.root.join("app", "scripts")
  config.no_wrap = true

  # Properly namespace each item
  config.each_framework do |framework|
    config.change_output_prefix! framework.name, "vendor/#{framework.name}"
  end
  config.change_output_prefix! :default, 'tedxperth'
  
end