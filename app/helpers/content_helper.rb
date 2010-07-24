module ContentHelper
  
  def social_media_link(name, text, link)
    link_to text.html_safe, link, :title => text, :class => "social-media-link #{name.to_s.dasherize}"
  end
  
  def render_page!(page, options = {})
    content = ActiveSupport::SafeBuffer.new
    content << content_tag(:header, content_tag(:h1, options[:title])) if options[:title]
    content << page.content_as_html
    content_tag(:article, content, :class => "page-content #{page.key.gsub(".", "-")}")
  end
  
  def content_options(form, field, opts = {})
    if form.object.send(:format_for, field) == "raw"
      opts.merge(:wrapper_html => {:class => 'ckeditor'})
    else
      opts
    end
  end
  
  def eml(text, url, options = {})
    expanded_text = options.delete(:title)
    expanded = options.delete(:expanded)
    if expanded
      inner = ActiveSupport::SafeBuffer.new
      inner << content_tag(:span, text, :class => 'menu-item-title')
      inner << content_tag(:span, expanded_text, :class => 'menu-item-expanded') unless expanded_text.blank?
    else
      inner = text
      options.merge! :title => expanded_text
    end
    ml inner, url, options
  end
  
end