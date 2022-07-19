class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    @record == @user || @user.admin?
  end

  def destroy?
    @user.admin?
  end

  def edit?
    @record.id == @user.id
  end

end
