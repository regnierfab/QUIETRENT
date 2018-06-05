class SinistrePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.locataire.user == user
  end


  def update?
    record.locataire.user == user
  end
end
