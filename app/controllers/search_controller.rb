class SearchController < ApplicationController
  
  def search
    @posts       = Post.published.for_listing.with_query(params[:query]).all
    @pages       = Page.published.for_menu.with_query(params[:query]).all
    @events      = Event.viewable.for_sidebar.with_query(params[:query]).all
    @total_count = (@posts.size + @pages.size + @events.size)
  end
  
end
