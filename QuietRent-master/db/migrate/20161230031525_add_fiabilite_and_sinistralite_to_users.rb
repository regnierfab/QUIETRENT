class AddFiabiliteAndSinistraliteToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fiabilite_parc, :string
    add_column :users, :sinistralite_parc, :string
  end
end
