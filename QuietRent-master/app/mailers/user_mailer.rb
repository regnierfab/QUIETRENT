class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user  # Instance variable => available in view
    mail(to: @user.email, subject: 'Bienvenue sur QuietRent!')
    # This will render a view in `app/views/user_mailer`!
  end

  def recap_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'QuietRent: Récapitulatif de la proposition')
  end

  def confirmation_locataire(user, locataire, resolution)
    @user = user
    @resolution = resolution
    @locataire = locataire
    mail(to: @locataire.email, subject: 'QuietRent: Proposition de résolution amiable')
  end

  def locataire_credentials(locataire, locataire_user, devise_password)
    @locataire = locataire
    @locataire_user = locataire_user
    @devise_password = devise_password
    mail(to: @locataire.email, subject: 'QuietRent: Envoi de vos identifiants de connexion')
  end

  def resolution_status(user, resolution)
    @user = user
    @resolution = resolution
    @name = 'resolution' + '-' + @resolution.locataire.firstname + '-' + @resolution.locataire.lastname
    attachments["#{@name}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: "#{@name}" , template: 'resolutions/show.pdf.erb', layout: 'pdf.html')
    )
    mail(to: @user.email, subject: 'QuietRent: Vous avez reçu une réponse à votre proposition')
  end

  def resolution_status_loc(user, locataire)
    @user = user
    @locataire = locataire
    mail(to: @locataire.email, subject: 'QuietRent: Confirmation de votre proposition amiable')
  end
end
