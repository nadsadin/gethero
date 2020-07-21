class PersonalPagesController < ApplicationController
  layout 'clientside/standard'
  def show
    @personal_page = PersonalPage.friendly.find(params[:id])
    redirect_to root_path unless @personal_page.approved_at
    @back_default = root_path
  end
end