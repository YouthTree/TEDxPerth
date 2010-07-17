require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
  layout 'tedxperth'
  
  include TitleEstuary
  use_controller_exts :translation, :title_estuary
end
