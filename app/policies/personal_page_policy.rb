class PersonalPagePolicy < ApplicationPolicy
  def new?
    @user.celebrity?
  end
  def index?
    is_admin?
  end
  def show?
    is_owner?||is_admin?
  end
  def destroy?
    is_owner?||is_admin?
  end
  def is_owner?
    @user == @record.user
  end
  def approve?
    is_admin?
  end
  def remove_approve?
    is_admin?
  end

  def permitted_attributes
    if user.celebrity?
      [:title, :body, :tag_list]
    else
      [:tag_list]
    end
  end
end