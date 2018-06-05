class CreateLocataires < ActiveRecord::Migration[5.0]
  def change
    create_table :locataires do |t|
      t.string :firstname
      t.string :lastname
      t.string :rue_address
      t.string :ville_address
      t.string :codepostal_address
      t.string :fiabilite_pers
      t.string :sinistralite_pers
      t.string :montant_loyer
      t.string :revenus
      t.string :situation_pro
      t.string :situation_fam
      t.string :age_birth

      t.timestamps
    end
  end
end
