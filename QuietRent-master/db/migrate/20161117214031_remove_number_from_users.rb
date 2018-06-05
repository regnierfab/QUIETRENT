class RemoveNumberFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :number, :integer
  end
end
