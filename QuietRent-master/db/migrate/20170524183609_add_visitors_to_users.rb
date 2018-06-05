class AddVisitorsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :visitor, :string, array: true, default: []
  end
end
