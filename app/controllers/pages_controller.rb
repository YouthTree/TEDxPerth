class PagesController < ApplicationController
  
  def index
    @page             = Page.published.home
    @blog_posts       = Post.ordered.published.limit(3).all
    @event            = Event.next
    @banner_items     = BannerItem.published.all
    @extra_content_classes = %w(homepage)
    add_title_variables! :title => @page.title
    hide_sidebar!
  end

  def show
    @page = Page.published.renderable.find_using_slug!(params[:id])
    add_title_variables! :title => @page.title
  end

end
