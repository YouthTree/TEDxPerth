require "application_responder"

class ApplicationController < ActionController::Base

  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
  layout 'tedxperth'
  
  include TitleEstuary
  use_controller_exts :translation, :title_estuary, :authlogic_helpers,
                      :authorization_helpers, :sidebar
                      
  protected

  def tf(key, opts = {})
    I18n.t(key.to_sym, opts.merge(:scope => :flash))
  end

end
