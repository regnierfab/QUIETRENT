class Resolution < ApplicationRecord
  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_created_at_gte
    ]
    )
  belongs_to :user
  belongs_to :locataire
  belongs_to :sinistre
  # after_create :proposition
  validates :motif_prejudice, :description, :nombre_paiement, :paiement_le, :montant_reduction, :montant_prejudice, presence: true
  validates :paiement_sur, inclusion: { in: ["3 Mois","6 Mois","9 Mois","12 Mois","18 Mois","24 Mois"],
    message: "%{value} n'est pas une bonne durée!" }, presence: true
  validates :status, inclusion: { in: ["Proposition envoyée","Résolution acceptée","Résolution refusée", nil],
      message: "%{value} n'est pas un bon status!" }



  scope :search_query, lambda { |query|
  # Searches the students table on the 'first_name' and 'last_name' columns.
  # Matches using LIKE, automatically appends '%' to each term.
  # LIKE is case INsensitive with MySQL, however it is case
  # sensitive with PostGreSQL. To make it work in both worlds,
  # we downcase everything.
  return nil  if query.blank?

  # condition query, parse into individual keywords
  terms = query.downcase.split(/\s+/)

  # replace "*" with "%" for wildcard searches,
  # append '%', remove duplicate '%'s
  terms = terms.map { |e|
    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }
  # configure number of OR conditions for provision
  # of interpolation arguments. Adjust this if you
  # change the number of OR conditions.
  num_or_conds = 2

  joins(:locataire).
  where(
    terms.map { |term|
      "(LOWER(locataires.firstname) LIKE ? OR LOWER(locataires.lastname) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
      )
}


scope :with_created_at_gte, lambda { |ref_date|
  where('resolutions.paiement_le >= ?', ref_date)
}

scope :sorted_by, lambda { |sort_option|
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^motif_prejudice_/
    order("LOWER(resolutions.motif_prejudice) #{ direction }")
  when /^montant_prejudice_/
    order("(resolutions.montant_prejudice) #{ direction }")
  when /^montant_reduction_/
    order("(resolutions.montant_reduction) #{ direction }")
  when /^paiement_le_/
    order("resolutions.paiement_le #{ direction }")
  when /^created_at_/
    order("resolutions.created_at #{ direction }")
  else
    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
}

def self.options_for_sorted_by
  [
    ['Date de création (+ récent)', 'created_at_desc'],
    ['Date de création (- récent)', 'created_at_asc'],
    ['Paiement le (+ récent)', 'paiement_le_asc'],
    ['Motif préjudice (a-z)', 'motif_prejudice_asc'],
    ['Montant préjudice', 'montant_prejudice_desc'],
    ['Montant réduction', 'montant_reduction_desc']
  ]
end

def self.per_page
  10
end

private


  # def proposition
  #   UserMailer.recap_confirmation(self.user).deliver!
  #   UserMailer.confirmation_locataire(self.user, self.locataire, self).deliver!
  # end
end
