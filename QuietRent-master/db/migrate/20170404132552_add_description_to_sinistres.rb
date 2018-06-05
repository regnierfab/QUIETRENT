class AddDescriptionToSinistres < ActiveRecord::Migration[5.0]
  def change
    add_column :sinistres, :description, :text
  end
end
