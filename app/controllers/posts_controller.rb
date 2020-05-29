class PostsController < ApplicationController
  layout 'clientside/standard'

  def index
    @posts = Post.all.order(:created_at)
  end

  def show
    @post = Post.friendly.find(params[:id])
    render layout: 'clientside/transparent_top_bar'
  end
end