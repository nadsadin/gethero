class CategoryPolicy < ApplicationPolicy
  def index?
    is_admin?
  end
  def new?
    is_admin?
  end
end