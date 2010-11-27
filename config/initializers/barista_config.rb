# Configure barista.
Barista.configure do |c|
  c.bare!
  c.root    = Rails.root.join("app", "coffeescripts")
  c.each_framework do |framework|
    c.change_output_prefix! framework.name, "vendor/#{framework.name}"
  end
  # Vendor in CoffeeScript 0.9.5
  c.js_path = Rails.root.join('public', 'javascripts', 'vendor', 'coffee-script-0.9.5.js').to_s
end