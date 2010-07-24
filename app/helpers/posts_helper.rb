module PostsHelper
  
  def paged_posts_path(page = nil)
    posts_path(:page => page)
  end

  def summary_with_full_link(post, options = {})
    html = first_paragraph_of post.summary_as_html
    if options[:rss]
      link = link_to "Continue reading on the Blog &raquo;".html_safe, post_url(post), :class => 'view-more'
    else
      link = link_to "Continue Reading &raquo;".html_safe, post_path(post), :class => 'view-more'
    end
    html.gsub(/(\.|\!|\?)?\s*<\/p>/) { "#{$1 || "."} #{link}</p>" }.html_safe
  end
  
  def full_post_content_for_rss(post)
    content = post.content_as_html
    content = absolutize_links(content) 
    link = link_to "View post / comment on Blog &raquo;".html_safe, post_url(post), :class => 'view-more'
    content << content_tag(:p, link)
    content
  end
  
  def pagination_links_for(collection)
    inner = []
    inner << link_to_page(collection.next_page,     '&laquo; View Older Posts', :class => 'older-posts')
    inner << link_to_page(collection.previous_page, 'View Newer Posts &raquo;', :class => 'newer-posts')
    content_tag(:div, inner.sum(ActiveSupport::SafeBuffer.new), :class => 'pagination')
  end
  
  def in_year_order(posts)
    collections = ActiveSupport::OrderedHash.new([])
    years = posts.map { |p| p.published_at.year }.uniq.sort.reverse
    years.each do |year|
      yield year, posts.select { |p| p.published_at.year == year } if block_given?
    end
  end
  
  def in_month_order(posts)
    months = posts.map { |p| p.published_at.month }.uniq.sort.reverse
    months.each do |month|
      ordered_posts = posts.select { |p| p.published_at.month == month }.sort_by(&:published_at).reverse
      yield Time.utc(Time.now.year, month).strftime("%B"), ordered_posts if block_given?
    end
  end
  
  def disqus_identifier_for(object)
    "#{object.class.model_name.underscore.dasherize}-#{object.id}"
  end
  
  def has_disqus_site_identifier
    inner = ActiveSupport::SafeBuffer.new
    inner << meta_tag("disqus-site", Settings.disqus.site) if Settings.disqus.site?
    inner << meta_tag("disqus-developer", "true") unless Rails.env.production?
    content_for :extra_head, inner
  end
  
  def has_disqus_identifier_for(object)
    has_disqus_site_identifier
    content_for :extra_head, meta_tag("disqus-identifier", disqus_identifier_for(object))
  end
  
  protected
  
  def link_to_page(page, text, options = {})
    if page.nil?
      content_tag :span, text.html_safe, options
    else
      link_to text.html_safe, paged_posts_path(page), options
    end
  end
  
end
