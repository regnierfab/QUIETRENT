class RenameDensiteCityToEvaluations < ActiveRecord::Migration[5.0]
  def change
    rename_column :evaluations, :edp_densite_urbaine, :edp_city
  end
end
