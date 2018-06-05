class ChangeTypeOfFiabiliteParcToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :fiabilite_parc, 'integer USING CAST(fiabilite_parc AS integer)'
  end
end
