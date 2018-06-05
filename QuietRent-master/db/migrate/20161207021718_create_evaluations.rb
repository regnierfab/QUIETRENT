class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.string :edp_loyer
      t.string :edp_situation_familiale
      t.string :edp_revenus_mensuels
      t.string :edp_classe_age
      t.string :edp_contrat_travail
      t.string :edp_densite_urbaine

      t.timestamps
    end
  end
end
