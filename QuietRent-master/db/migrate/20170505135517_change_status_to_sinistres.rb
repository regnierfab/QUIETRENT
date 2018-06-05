class ChangeStatusToSinistres < ActiveRecord::Migration[5.0]
  def change
    change_column :sinistres, :status, :string, :default => "En cours"
  end
end
