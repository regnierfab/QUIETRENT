class CreateFiabilites < ActiveRecord::Migration[5.0]
  def change
    create_table :fiabilites do |t|
      t.integer :fiabilite_parc
      t.references :user, foreign_key: true, index: true
      t.date :date_fiabilite

      t.timestamps
    end
  end
end
