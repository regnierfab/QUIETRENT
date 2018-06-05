class AddEdpresultToEvaluations < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :result_edp, :string
  end
end
