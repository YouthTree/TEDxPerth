module ContentHelper
  
  def social_media_link(name, text, link)
    link_to text.html_safe, link, :title => text, :class => "social-media-link #{name.to_s.dasherize}"
  end
  
  def render_page!(page)
    content_tag(:article, page.content_as_html, :class => "page-content #{page.key.gsub(".", "-")}")
  end
  
end