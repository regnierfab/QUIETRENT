class ChangeTypeOfColumnToEvaluations < ActiveRecord::Migration[5.0]
  def change
    change_column :evaluations, :edp_loyer, 'integer USING CAST(edp_loyer AS integer)'
    change_column :evaluations, :edp_revenus_mensuels, 'integer USING CAST(edp_revenus_mensuels AS integer)'
  end
end
