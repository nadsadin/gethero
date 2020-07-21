class CustomRegistrationsController < ApplicationController
  layout 'clientside/standard'
  def new
    @custom_registration = CustomRegistration.new
  end

  def create
    @custom_registration = CustomRegistration.new
    @company = Company.new(company_params)
    if @company.save
      @location = @company.locations.build(location_params)
      if @location.save
        @user = User.new(client_params)
        @user.role = :company_admin
        @user.company=@company
        if @user.save
          redirect_to sign_up_success_path
        else
          @location.destroy
          @company.destroy
          render :new
        end
      else
        @company.destroy
        render :new
      end
    else
      render :new
    end
  end

  def successful_registration

  end

  private

  def resolve_layout
    case action_name
    when 'new', 'create'
      'main/layout-custom-registration'
    else
      'main/layout-devise'
    end
  end

  def client_params
    params.require(:custom_registration).permit(:email, :password, :password_confirmation, :name, :surname)
  end
  def company_params
    params.require(:custom_registration).permit(:title, :legal_address, :inn, :kpp, :ogrn, :ceo, :role)
  end
  def location_params
    params.require(:custom_registration).permit(:location_title, :address, :phone, :short_description, :website, :category_id, :logo, :preview)
  end
end