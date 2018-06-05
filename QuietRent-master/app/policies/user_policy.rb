class UserPolicy < ApplicationPolicy
  def show?
    user == user
  end

  def update?
    record == user
  end

  def import_loc?
    true
  end


  def infentreprise?
    true
  end

end
