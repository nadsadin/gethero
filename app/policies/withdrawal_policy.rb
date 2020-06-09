class WithdrawalPolicy < ApplicationPolicy
  def new?
    @user.celebrity?
  end

  def index?
    @user.celebrity? || is_admin?
  end

  def is_owner?
    @user == @record.user
  end

  def show?
    is_owner?||is_admin?
  end

  def cc_confirmation?
    @user.celebrity?
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
        @user.withdrawals
      else
        scope.limit(0)
      end
    end
  end
end