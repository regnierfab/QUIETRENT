# desc "Calculate_fiabilite_global"
# task :update_fiabilite => :environment do
#   puts "Updating fiabilite..."
#   User.all.each do |u|
#     u.calculate_fiabilite_global
#   end
#   puts "done."
# end
#
desc "Save fiabilite of all user by month"
task save_fiabilite: [:environment] do
  if Time.now.day == 31
  User.save_fiabilite
  end
end

desc "Reset Token for API"
task reset_api: [:environment] do
  User.reset_token
end
#
# desc "calculate_fiabilite"
# task :update_fiabilite_loc => :environment do
#   puts "Update fiabilite locataire..."
#   Locataire.all.each do |l|
#     l.calculate_fiabilite
#   end
#   puts "done."
# end
