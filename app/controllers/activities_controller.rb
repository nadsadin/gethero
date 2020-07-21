class ActivitiesController < ApplicationController
  def show
    @activity = Activity.friendly.find(params[:id])
  end
end