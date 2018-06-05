class Fiabilite < ApplicationRecord
  belongs_to :user

  private

  def self.hausse_baisse_fiabilites(id)
    m = User.find(id).fiabilites.where('created_at > ?', 3.month.ago)
    first_fiabilite = m.first.fiabilite_parc
    last_fiabilite = m.last.fiabilite_parc
    result = last_fiabilite - first_fiabilite
    if result > 0
      return "La fiabilité de votre parc à augmenter de <b style='color: #F18132'>#{result}</b> points au cours des <b style='color: #F18132'>3</b> derniers mois".html_safe
    else
      return "La fiabilité de votre parc à baisser de <b style='color: #F18132'>#{result}</b> points au cours des <b style='color: #F18132'>3</b> derniers mois".html_safe
    end
  end
end
