class PagesController < ApplicationController
  layout 'clientside/standard'

  def show
    @page = Page.friendly.find(params[:id])
  end
end