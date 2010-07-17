Rails.application.config.session_store :cookie_store, :key => Settings.fetch(:session_key, '_TEDxPerth_session')

Rails.application.config.secret_token = Settings.secret_token
Carmen.default_country                = "AU"
BHM::Admin.site_name                  = "TEDxPerth"

Haml.init_rails(binding) if defined?(Haml)
Haml::Template.options[:format] = :html5

Pseudocephalopod::Slug.class_eval do
  attr_accessible :slug, :scope, :record_id
end

BHM::GoogleMaps.include_js_proc = proc do |t|
  t.has_js t.google_maps_url(false)
  t.has_jammit_js :gmap
end