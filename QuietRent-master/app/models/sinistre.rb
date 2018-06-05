class Sinistre < ApplicationRecord
  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_created_at_gte
    ]
  )
  belongs_to :locataire
  has_many :resolutions
  validates :locataire, presence: true
  validates :category, presence: true
  validates :start_date, presence: true, uniqueness: { scope: :locataire_id }
  validates :status, inclusion: { in: ["En cours", "Résolu", "Annulé", "Mail envoyé"]}


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
    where('sinistres.start_date >= ?', ref_date)
  }

  scope :sorted_by, lambda { |sort_option|
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^lastname/
    order("LOWER(locataires.lastname) #{ direction }")
  when /^category/
    order("LOWER(sinistres.category) #{ direction }")
  when /^date/
    order("sinistres.start_date #{ direction }")
  when /^status/
    order("LOWER(sinistres.status) #{ direction }")
  when /^firstname/
    order("LOWER(locataires.firstname) #{ direction }")
  when /^created_at_/
  order("sinistres.created_at #{ direction }")
  else
    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
}

  def self.options_for_sorted_by
    [
      ['Nom (a-z)', 'lastname_asc'],
      ['Prenom (a-z)', 'firstname_asc'],
      ['Catégorie', 'category_asc'],
      ['Status', 'status_asc'],
      ['Date du sinistre', 'date_asc'],
      ['Date de création (+ récent)', 'created_at_desc'],
      ['Date de création (+ ancien)', 'created_at_asc']
    ]
  end

  def self.by_year(year)
    where('extract(year from start_date) = ?', year)
  end

  def by_year(year)
    where('extract(year from start_date) = ?', year)
  end

  def self.by_year_and_month(year, month)
    where('extract(year from start_date) = ? and extract(month from start_date) = ?', year, month)
  end

  def by_year_and_month(year, month)
    where('extract(year from start_date) = ? and extract(month from start_date) = ?', year, month)
  end

  def self.resolution_sinistres(id)
      p = User.find(id).sinistres
    if p.where(status: 'En cours').count > 0
      return "Votre parc comporte <b style='color: #F18132'>#{p.count}</b> sinistres non résolu".html_safe
    elsif p.count == 0
      return 'Vous n\'avez aucun sinistre'
    else
      return 'Tous vos sinistres sont résolus'
    end
  end

  def self.per_page
    10
  end
end
