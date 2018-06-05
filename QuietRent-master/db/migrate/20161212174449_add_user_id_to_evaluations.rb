class AddUserIdToEvaluations < ActiveRecord::Migration[5.0]
  def change
    add_reference :evaluations, :user, foreign_key: true
  end
end
