class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def show?
    true
  end

  def update?
    user.present?
  end

  def destroy?
    user == record.user || user.admin? if user
  end

  def private?
    user == record.user || user.admin? if user
  end
end
