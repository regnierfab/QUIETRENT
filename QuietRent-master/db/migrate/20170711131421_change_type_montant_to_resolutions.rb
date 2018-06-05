class ChangeTypeMontantToResolutions < ActiveRecord::Migration[5.0]
  def change
    change_column :resolutions, :montant_prejudice, 'integer USING CAST(montant_prejudice AS integer)'
    change_column :resolutions, :montant_reduction, 'integer USING CAST(montant_reduction AS integer)'
  end
end
