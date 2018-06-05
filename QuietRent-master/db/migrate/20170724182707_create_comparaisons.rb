class CreateComparaisons < ActiveRecord::Migration[5.0]
  def change
    create_table :comparaisons do |t|
      t.integer :edp_loyerf
      t.integer :edp_loyerl
      t.string :edp_situation_familialef
      t.string :edp_situation_familialel
      t.integer :edp_revenus_mensuelsf
      t.integer :edp_revenus_mensuelsl
      t.string :edp_year_birthf
      t.string :edp_year_birthl
      t.string :edp_contrat_travailf
      t.string :edp_contrat_travaill
      t.string :edp_cityf
      t.string :edp_cityl
      t.references :user, foreign_key: true, index: true
      t.string :result_edpf
      t.string :result_edpl

      t.timestamps
    end
  end
end
