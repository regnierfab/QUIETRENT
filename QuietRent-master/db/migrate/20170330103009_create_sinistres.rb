class CreateSinistres < ActiveRecord::Migration[5.0]
  def change
    create_table :sinistres do |t|
      t.string :type
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.references :locataire, foreign_key: true, index: true

      t.timestamps
    end
  end
end
