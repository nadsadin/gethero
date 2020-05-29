class HomeController < ApplicationController
  layout 'clientside/standard'
  def index
    @pp_random = PersonalPage.all
    @posts = Post.all.order(:created_at).limit(3)
  end
end