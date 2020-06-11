class PersonalPagesController < ApplicationController

  def show
    @personal_page = PersonalPage.friendly.find(params[:id])
    @back_default = root_path
    render layout: 'clientside/standard'
  end
end