class UserPolicy < ApplicationPolicy
  def is_owner?
    @user == @record
  end
  def new?
    is_admin?
  end
  def index?
    is_admin?
  end


  def permitted_attributes
    if user.admin?
      [:email, :name, :surname, :avatar, :midname, :dob, :gender, :phone, :role, :inn]
    elsif user.celebrity?
      [:email, :name, :surname, :avatar, :midname, :dob, :gender, :phone, :inn]
    else
      [:email, :name, :surname, :avatar, :midname, :dob, :gender, :phone]
    end
  end
end