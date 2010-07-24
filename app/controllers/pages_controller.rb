class PagesController < ApplicationController
  
  def index
    @page  = Page.published.home
    @event = Event.next
    add_title_variables! :title => @page.title
  end

  def show
    @page = Page.published.renderable.find_using_slug!(params[:id])
    add_title_variables! :title => @page.title
  end

end
