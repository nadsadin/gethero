class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_action :set_menu_categories
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_root_path
  end
  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || admin_root_path)
  end

  def set_menu_categories
    @menu_categories = Category.all
  end

  before_action do
    @back_default = root_path
  end
end
