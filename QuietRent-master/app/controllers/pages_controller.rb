class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :private_locataire, only: :espace_locataire

  def home
  end

  def espace_locataire
    @user = current_user
    @a = []
    Resolution.all.each do |r|
      @a << r if @user.email == r.locataire.email
    end
 end



 private


 def private_locataire
  redirect_to root_path, alert: 'Accès interdit.' unless current_user.role == "Locataire"
end
end
