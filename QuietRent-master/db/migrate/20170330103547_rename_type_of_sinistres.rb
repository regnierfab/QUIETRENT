class RenameTypeOfSinistres < ActiveRecord::Migration[5.0]
  def change
    rename_column :sinistres, :type, :category
  end
end
