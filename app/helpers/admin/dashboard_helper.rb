module Admin::DashboardHelper
  
  def clicky_meta_tags
    clicky = Settings.clicky
    content_for(:extra_head, meta_tag("clicky-site-id", clicky.site_id))   if clicky.site_id?
    content_for(:extra_head, meta_tag("clicky-site-key", clicky.site_key)) if clicky.site_key?
    nil
  end
  
end