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
    user.present? && user == record.user || user.admin?
  end
end
