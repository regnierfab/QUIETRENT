class ChangeTypeOfFiabilitePersForLocataires < ActiveRecord::Migration[5.0]
  def change
    change_column :locataires, :fiabilite_pers, 'integer USING CAST(fiabilite_pers AS integer)'
  end
end
