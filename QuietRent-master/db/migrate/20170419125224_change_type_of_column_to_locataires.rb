class ChangeTypeOfColumnToLocataires < ActiveRecord::Migration[5.0]
  def change
    change_column :locataires, :montant_loyer, 'integer USING CAST(montant_loyer AS integer)'
    change_column :locataires, :revenus, 'integer USING CAST(revenus AS integer)'
  end
end
