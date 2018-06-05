class Api::V1::EvaluationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_evaluation, only: [ :show ]
  before_action :error_plan


    def show
    end

    def index
      @evaluations = policy_scope(Evaluation).where(user: current_user)
    end

    def create
        evaluations =  []
        evaluation_params.each do |p|
          @evaluation = Evaluation.new(p)
          @evaluation.user = current_user
          evaluations << @evaluation if @evaluation.save
        end
        authorize @evaluation
        if @evaluation.save
          render json: evaluations, status: :created
        else
          render_error
        end
    end

  private


  def evaluation_params
      params.require(:evaluation).map do |p|
        ActionController::Parameters.new(p.to_unsafe_h).permit(:edp_loyer, :edp_situation_familiale, :edp_revenus_mensuels, :edp_year_birth, :edp_contrat_travail, :edp_city)
    end
  end

  def render_error
      render json: { errors: @evaluation.errors.full_messages },
      status: :unprocessable_entity
  end

  def error_plan
    if current_user.subscription == nil or current_user != User.find_by_email('arye@quietrent.com')
      render json: { errors: "Passez au PLAN BUSINESS pour bénéficier de l'API." },
      status: :unprocessable_entity
    end
  end

   def set_evaluation
     @evaluation = Evaluation.find(params[:id])
     authorize @evaluation  # For Pundit
   end

end
