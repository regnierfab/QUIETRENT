# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.find(14).locataires.destroy_all
#  puts "destroy all locataire done..."
#   500.times do
#     l = Locataire.new(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, montant_loyer: rand(500...1500), revenus: rand(2000...3000),
#      situation_pro: ['CDI', 'CDD de plus de 8 mois', 'Retraité', 'Sans emploi', 'Indépendant (professions libérales, auto-entrepreneur, etc...)', 'Contrat précaire (étudiant,saisonnier, interim, mi-temps, etc...)'].sample,
#      situation_fam: ['Seul', 'Couple sans enfant', 'Couple avec enfant', 'Famille monoparentale'].sample, age_birth: rand(1930...2015), user: User.find(14), street: Faker::Address.street_address, zip_code: Faker::Address.zip_code, city: Faker::Address.city )
#     l.save!
#   end
#   puts "Create all locataire done..."
#



  User.find(29).locataires.destroy_all
  puts "destroy all locataire done..."
   200.times do |n|
     l = Locataire.new(
      firstname: Faker::Name.unique.first_name,
      lastname: Faker::Name.unique.last_name,
      montant_loyer: rand(500...1500),
      revenus: rand(1500...3000),
      situation_pro: ['CDI', 'CDD de plus de 8 mois', 'Retraité', 'Sans emploi', 'Indépendant (professions libérales, auto-entrepreneur, etc...)', 'Contrat précaire (étudiant, saisonnier, interim, mi-temps, etc...)'].sample,
      situation_fam: ['Seul', 'Couple sans enfant', 'Couple avec enfant', 'Famille monoparentale'].sample,
      age_birth: rand(1930...2015),
      user: User.find(29),
      street: Faker::Address.street_address,
      zip_code: Faker::Address.zip_code,
      city: "Paris"
      )
     l.save!
     puts "1 locataire saved."
   end
   puts "Create all locataire done..."

#   a = Locataire.all
#   a.each do |loc|
#     loc.calculate_fiabilite
#     loc.save
#   end
# puts "Calculate the fiabilite_pers done..."
