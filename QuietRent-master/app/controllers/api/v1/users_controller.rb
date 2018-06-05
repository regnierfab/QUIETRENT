class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [ :show ]
  before_action :error_plan

  def show
    if @user = User.find_by_email(request.params['email']) and @user.valid_password?(request.params['password']) #and @user.subscription.plan.id == 3
    else
      render_error
    end
  end

  private


  def render_error
      render json: { errors: "Problème d'authentification, vérifier vos informations." },
      status: :unprocessable_entity
  end

  def set_user
    @user = User.find(params[:id])
    authorize @user  # For Pundit
  end

  def error_plan
    if @user.subscription == nil or @user != User.find_by_email('arye@quietrent.com')
      render json: { errors: "Passez au PLAN BUSINESS pour bénéficier de l'API." },
      status: :unprocessable_entity
    end
  end
end
