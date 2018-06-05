class EvaluationPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.user == user
  end

  def show?
    record.user == user
  end
end
