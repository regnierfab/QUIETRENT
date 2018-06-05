class AddImportsinistraliteToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :import_sinistralite, :string
  end
end
