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
  
end