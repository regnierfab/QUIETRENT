class ResolutionsController < ApplicationController
  before_action :set_resolution, only: [:show, :edit, :update]
  before_action :authorize_plan_2

  def index
    @evaluation = Evaluation.new
    @locataire = Locataire.new
    @sinistre = Sinistre.new
    @filterrific = initialize_filterrific(
      Resolution.where(user: current_user),
      params[:filterrific],
      select_options: {
        sorted_by: Resolution.options_for_sorted_by
      },
      persistence_id: false,
      available_filters: [:search_query, :sorted_by, :with_created_at_gte]
    ) or return
      @resolutions = @filterrific.find.page(params[:page]).where(user: current_user)
      respond_to do |format|
       format.html
       format.js
      end
      rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def show
    @locataire = Locataire.new
    @evaluation = Evaluation.new
    @sinistre = Sinistre.new
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'resolution' + '-' + @resolution.locataire.firstname + '-' + @resolution.locataire.lastname,
               template: 'resolutions/show',
               layout: 'pdf.html'
      end
    end
  end

  def new
    @resolution = Resolution.new
  end

  def create
    @resolution = Resolution.new(resolution_params)
    if @resolution.locataire.email == ""
      flash[:alert] = "Renseignez l'email de votre locataire."
      redirect_to(edit_locataire_path(@resolution.locataire)) and return
    end
    @resolution.user = current_user
    @resolution.locataire = Locataire.find(params[:resolution][:locataire_id])
    @resolution.sinistre = Sinistre.find(params[:resolution][:sinistre_id])
    @resolution.sinistre.status = "Mail envoyé"
    @resolution.sinistre.save
    if User.find_by_email(@resolution.locataire.email) == nil
      generated_password = Devise.friendly_token.first(10)
      locataire_user = User.create!(email: @resolution.locataire.email, password: generated_password, denomination: "#{@resolution.locataire.firstname}-#{@resolution.locataire.lastname}", role: 'Locataire', firstname: @resolution.locataire.firstname, lastname: @resolution.locataire.lastname)
      UserMailer.locataire_credentials(@resolution.locataire, locataire_user, generated_password).deliver_now
    end
    if @resolution.save
      UserMailer.recap_confirmation(@resolution.user).deliver_now
      UserMailer.confirmation_locataire(@resolution.user, @resolution.locataire, @resolution).deliver_now
      redirect_to resolution_path(@resolution.id), notice: 'Votre contrat amiable a bien été crée.'
    else
      redirect_to :back
    end
  end

  def edit
  end

  def update
    @resolution.update(resolution_params)
    if @resolution.status != nil
      UserMailer.resolution_status(@resolution.user, @resolution).deliver_now
      UserMailer.resolution_status_loc(@resolution.user, @resolution.locataire).deliver_now
    end
    redirect_to espace_locataire_path
  end


  private

  def authorize_plan_2
    unless current_user.role == "Proprietaire" and current_user.subscription.try(:plan) == Plan.find(2)
      redirect_to pricing_path, alert: 'Passez au PLAN STANDARD pour bénéficier de la résolution amiable.'
    end
  end

  def set_resolution
    @resolution = Resolution.find(params[:id])
  end

  def resolution_params
    params.require(:resolution).permit(:motif_prejudice, :montant_prejudice, :montant_reduction, :paiement_sur, :paiement_le, :nombre_paiement, :description, :status, :commentaire_loc, :locataire_id, :sinistre_id)
  end
end
