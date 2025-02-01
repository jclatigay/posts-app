class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      else
        scope.published.or(scope.where(user: user))
      end
    end
  end

  def index?
    true
  end

  def show?
    record.published? || user_is_admin? || user_is_moderator? || record.user == user
  end

  def create?
    true
  end

  def update?
    user_is_admin? || user_is_moderator? || record.user == user
  end

  def destroy?
    user_is_admin? || (user_is_moderator? && !record.user.admin?) || record.user == user
  end

  def publish?
    user_is_admin? || user_is_moderator?
  end
end
