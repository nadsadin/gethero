class PersonalPagesController < ApplicationController

  def show
    @personal_page = PersonalPage.friendly.find(params[:id])
    render layout: 'clientside/transparent_top_bar'
  end
end