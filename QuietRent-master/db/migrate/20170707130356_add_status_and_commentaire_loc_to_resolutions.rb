class AddStatusAndCommentaireLocToResolutions < ActiveRecord::Migration[5.0]
  def change
    add_column :resolutions, :status, :string
    add_column :resolutions, :commentaire_loc, :text
  end
end
