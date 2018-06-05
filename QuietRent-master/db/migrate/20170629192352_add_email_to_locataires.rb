class AddEmailToLocataires < ActiveRecord::Migration[5.0]
  def change
    add_column :locataires, :email, :string
  end
end
