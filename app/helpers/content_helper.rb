module ContentHelper
  
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
  
  def meta_for_page!(page)
    content_for(:extra_head, meta_tag(:description, page.description)) if page.description?
    content_for(:extra_head, meta_tag(:keywords, page.keywords))       if page.keywords?
  end

  def slider_for(*args)
    options = args.extract_options!
    inner = args.flatten.map { |i| image_tag(i) }.sum(ActiveSupport::SafeBuffer.new)
    content_tag(:div, inner, options.merge(:class => 'image-slider'))
  end
  
end