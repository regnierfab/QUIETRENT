class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pundit: white-list approach.
  # after_action :verify_authorized, except: [:download_xlsx, :import_xlsx], unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized

def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:profil])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:firstname])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:lastname])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:number])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:lot])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:denomination])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:address])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:import])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:import_sinistralite])
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profil])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:lot])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:denomination])
    devise_parameter_sanitizer.permit(:account_update, keys: [:import])
    devise_parameter_sanitizer.permit(:account_update, keys: [:import_sinistralite])
  end

  def default_url_options
  { host: ENV['HOST'] || 'localhost:3000' }
  end

  private

  def after_sign_in_path_for(resource)
    if resource.role == "Locataire"
      espace_locataire_path
    elsif resource.role == "Proprietaire"
      user_path(resource)
    else
      root_path
    end
  end
 # def skip_pundit?
 #   devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
 # end


end
