class SinistresController < ApplicationController
  before_action :set_sinistre, only: [:update, :show]
  before_action :authorize_plan_2, only: :show
  before_action :authorize_plan

  def create
    @sinistre = Sinistre.new(sinistre_params)
    @sinistre.locataire = Locataire.find(params[:locataire_id])
    respond_to do |format|
      if @sinistre.save
        format.js { flash.now[:notice] = 'Le sinistre a bien été crée.' }
      else
        format.js { flash.now[:alert] = 'Le sinistre n\'a pas été crée, la période est déjà utilisée.' }
      end
    end
  end

    def index
      @evaluation = Evaluation.new
      @locataire = Locataire.new
      @filterrific = initialize_filterrific(
      Sinistre.where(locataire: current_user.locataires),
      params[:filterrific],
      select_options: {
        sorted_by: Sinistre.options_for_sorted_by
      },
      persistence_id: false,
      available_filters: [:search_query, :sorted_by, :global_search, :with_created_at_gte]
    ) or return
      @sinistres = @filterrific.find.joins(:locataire).where(locataire: current_user.locataires)
      respond_to do |format|
       format.html
       format.js
      end
      rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{e.message}"
      redirect_to(reset_filterrific_url(format: :html)) && return
    end

    def update
      @sinistre.update(sinistre_params)
      redirect_to user_path(current_user)
    end

    def show
      @user = current_user
      @evaluation = Evaluation.new
      @locataire = Locataire.new
      @resolution = Resolution.new
    end

    def maj_sinistres
      @evaluation = Evaluation.new
      @locataire = Locataire.new
      @locataires = Locataire.where(user: current_user)
      @first_results = params[:search]
      @results = @locataires.global_search(@first_results)
      end

  private


    def authorize_plan_2
      unless current_user.role == "Proprietaire" and current_user.subscription.try(:plan) == Plan.find(2)
        redirect_to pricing_path, alert: 'Passez au PLAN STANDARD pour bénéficier de la résolution amiable.'
      end
    end

    def authorize_plan
      redirect_to pricing_path, alert: 'Vous n\'avez aucun abonnement.' unless current_user.role == "Proprietaire" && current_user.subscription.try(:plan) != nil
    end

    def set_sinistre
        @sinistre = Sinistre.find(params[:id])
    end

    def sinistre_params
        params.require(:sinistre).permit(:category, :start_date, :end_date, :status, :description)
    end
end
