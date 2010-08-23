# Configure barista.
Barista.configure do |c|

  c.root    = Rails.root.join("app", "coffeescripts")
  c.no_wrap = true

  c.each_framework do |framework|
    c.change_output_prefix! framework.name, "vendor/#{framework.name}"
  end
  
end

# Preferrerd place.
Barista::Compiler.bin_path = "/usr/local/bin/coffee" if File.executable?("/usr/local/bin/coffee")