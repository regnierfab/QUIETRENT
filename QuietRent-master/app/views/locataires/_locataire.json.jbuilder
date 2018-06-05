json.extract! locataire, :id, :firstname, :lastname, :address, :fiabilite_pers, :sinistralite_pers, :montant_loyer, :revenus, :situation_pro, :situation_fam, :age_birth, :created_at, :updated_at
json.url locataire_url(locataire, format: :json)
