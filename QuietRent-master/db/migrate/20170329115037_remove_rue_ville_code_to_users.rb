class RemoveRueVilleCodeToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :locataires, :rue_address, :string
    remove_column :locataires, :ville_address, :string
    remove_column :locataires, :codepostal_address, :string
  end
end
