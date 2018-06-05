class CreateResolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :resolutions do |t|
      t.string :motif_prejudice
      t.string :montant_prejudice
      t.string :montant_reduction
      t.string :paiement_sur
      t.date :paiement_le
      t.string :nombre_paiement
      t.text :description
      t.references :user, foreign_key: true, index: true
      t.references :locataire, foreign_key: true, index: true

      t.timestamps
    end
  end
end
