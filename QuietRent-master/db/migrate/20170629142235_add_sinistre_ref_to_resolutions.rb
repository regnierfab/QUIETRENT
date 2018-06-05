class AddSinistreRefToResolutions < ActiveRecord::Migration[5.0]
  def change
    add_reference :resolutions, :sinistre, foreign_key: true, index: true
  end
end
