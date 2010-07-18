module Admin::ContentHelper
  
  def admin_content(object, field = :content)
    content_tag(:div, object.send(:"#{field}_as_html"), :class => "content")
  end
  
end