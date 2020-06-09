class PersonalPagesController < ApplicationController

  def show
    @personal_page = PersonalPage.friendly.find(params[:id])
    render layout: 'clientside/standard'
  end
end