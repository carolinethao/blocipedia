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

  def destroy
    user.admin? && user == record.user
  end
end
