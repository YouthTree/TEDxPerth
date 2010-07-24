module SidebarHelper
  
  def sidebar_content
    content_for :sidebar
  end
  
  def has_sidebar?
    sidebar_content.present?
  end
  
  def sidebar_contains(*args, &blk)
    content_for :sidebar, *args, &blk
  end
  
  def main_content_class
    has_sidebar? ? "left" : "full-width"
  end
  
  def render_to_sidebar!(partial_name, options = {})
    sidebar_contains render(options.merge(:partial => partial_name))
  end
  
end