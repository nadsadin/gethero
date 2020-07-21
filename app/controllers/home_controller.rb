class HomeController < ApplicationController
  layout 'clientside/standard'
  def index
    @pp_random = PersonalPage.approved
    @activities_new = Activity.all
    @posts = Post.all.order(:created_at).limit(3)
  end
end