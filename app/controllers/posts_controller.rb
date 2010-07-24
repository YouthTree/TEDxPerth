class PostsController < ApplicationController
  
  def index
    @posts = Post.ordered.published.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @post   = Post.find_using_preview_key(params[:id])
    @post ||= Post.published.find_using_slug!(params[:id])
    add_title_variables! :post_title => @post.title
  end
  
end
