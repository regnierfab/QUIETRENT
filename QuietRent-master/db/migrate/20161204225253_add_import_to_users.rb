class AddImportToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :import, :string
  end
end
