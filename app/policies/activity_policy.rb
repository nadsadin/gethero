class ActivityPolicy < ApplicationPolicy
  def new?
    @user.celebrity?
  end
  def index?
    is_admin? || @user.celebrity?
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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    def resolve
      if @user.admin?
        scope
      elsif @user.celebrity?
        @user.activities
      else
        scope.limit(0)
      end
    end
  end
end