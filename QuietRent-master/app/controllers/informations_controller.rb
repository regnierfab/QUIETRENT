require 'csv'
require 'roo'

class InformationsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:home]
    skip_before_action :verify_authenticity_token
    before_action :private_locataire


    def infentreprise
        # if current_user.denomination.blank? || current_user.address.blank?
        #   render :infentreprise
        # else
        #   redirect_to root_path
        # end
        @user = current_user
    end


    def download_xlsx
        xlsx_path = File.join(Rails.root, 'public')
        send_file(
            File.join(xlsx_path, 'Quietrent-import-locataires.xlsx'),
            filename: 'Quietrent-import-locataires.xlsx',
            type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
    end


    def import_loc
        @user = current_user
    end

  #   def import_csv
  #     if params[:file].nil?
  #       render :import_loc
  #     else
  #       headers_true = ['prenom locataire', ' nom locataire', ' rue', ' code postal', ' ville', ' loyer', ' revenus', ' situation professionnelle', ' situation familiale', ' annee de naissance']
  #       csv_options = { col_sep: ',', headers: :first_row }
  #       filepath = params[:file].path
  #       headers = CSV.read(filepath, headers: true).headers
  #       if headers == headers_true
  #           CSV.foreach(filepath, csv_options) do |row|
  #               l = Locataire.new(firstname: row[0], lastname: row[1], street: row[2], zip_code: row[3], city: row[4], montant_loyer: row[5], revenus: row[6], situation_pro: row[7], situation_fam: row[8], age_birth: row[9], user: current_user)
  #               unless l.lastname.nil?
  #               l.save!
  #               end
  #           end
  #           redirect_to user_path(current_user), notice: 'Votre fichier à bien été envoyer'
  #       else
  #           redirect_to informations_import_locataires_path, alert: 'Votre fichier est incorrect, merci de le corriger et le renvoyer'
  #       end
  #      end
  # end # def

    def import_xlsx
      if params[:xlsx].nil?
        render :import_loc
      else
        filepath = params[:xlsx].path
        xlsx = Roo::Spreadsheet.open(filepath)
        xlsx = Roo::Excelx.new(filepath)
        xlsx.default_sheet = xlsx.sheets.first
        csv = xlsx.to_csv
        csv_options = { col_sep: ',', headers: :first_row, quote_char: '"' }
        csv_new = CSV.new(csv)
        CSV.parse(csv, csv_options) do |row|
          l = Locataire.new(firstname: row[1], lastname: row[2], email: row[3], street: row[4], zip_code: row[5], city: row[6], montant_loyer: row[7], revenus: row[8], situation_pro: row[9], situation_fam: row[10], age_birth: row[11], user: current_user)
          unless l.lastname.nil?
          l.save!
          end
        end
        redirect_to user_path(current_user), notice: 'Votre fichier à bien été envoyer'
        # return redirect_to user_path(current_user), notice: 'Votre fichier à bien été envoyer'
      end
    end

    # def import_json
    #   if params[:json].nil?
    #     render :import_loc
    #   else
    #     file = params[:json]
    #     json = JSON.parse(file.open.read)
    #     json.map do |hash|
    #       a = Locataire.new(hash)
    #       a.user = current_user
    #       if a.valid?
    #       a.save!
    #       end
    #     end
    #     redirect_to user_path(current_user), notice: 'Votre fichier à bien été envoyer'
    #   end
    # end
    private

     def private_locataire
      redirect_to root_path, alert: 'Accès interdit.' unless current_user.role == "Proprietaire"
    end

end # class
