class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end
  def show?
    true
  end
  def new?
    is_admin?
  end
  def create?
    new?
  end
  def edit?
    is_owner?||is_admin?
  end
  def update?
    edit?
  end
  def destroy?
    is_admin?
  end
  def is_admin?
    @user.admin?
  end
  def is_owner?
    false
  end
  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end