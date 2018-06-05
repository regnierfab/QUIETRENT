class AddAddressToLocataires < ActiveRecord::Migration[5.0]
  def change
    add_column :locataires, :address, :string
  end
end
