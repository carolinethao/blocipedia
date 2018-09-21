class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def show?
    true if !record.private? || record.users.include?(user) || record.user == user
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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.try(:admin?)
        wikis = scope.all
      elsif user.try(:premium?)
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki
          end
        end
      else # standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.users.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
   end

end
