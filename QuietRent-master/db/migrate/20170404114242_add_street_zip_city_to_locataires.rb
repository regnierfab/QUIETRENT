class AddStreetZipCityToLocataires < ActiveRecord::Migration[5.0]
  def change
    add_column :locataires, :street, :string
    add_column :locataires, :zip_code, :string
    add_column :locataires, :city, :string
  end
end
