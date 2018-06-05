class RenameClassToEvaluations < ActiveRecord::Migration[5.0]
  def change
    rename_column :evaluations, :edp_classe_age, :edp_year_birth
  end
end
