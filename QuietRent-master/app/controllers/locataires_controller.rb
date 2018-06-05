class LocatairesController < ApplicationController
    before_action :set_locataire, only: [:show, :edit, :update]
    before_action :authorize_plan

    # GET /locataires
    # GET /locataires.json
    # def index
    #     @locataires = Locataire.where(user: current_user)
    #     @user = current_user
    #     respond_to do |format|
    #       format.html { redirect_to user_path(current_user) }
    #         format.js
    #     end
    # end


    def index
      @user = current_user
      @evaluation = Evaluation.new
      @locataire = Locataire.new
      @filterrific = initialize_filterrific(
      Locataire.where(user: current_user),
      params[:filterrific],
      select_options: {
        sorted_by: Locataire.options_for_sorted_by
      },
      persistence_id: false,
      available_filters: [:search_query, :sorted_by, :global_search]
    ) or return
      @locataires = @filterrific.find.page(params[:page]).where(user: current_user)
      respond_to do |format|
       format.html
       format.js
      end
      rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
    end

    # GET /locataires/1
    # GET /locataires/1.json
    def show
        @user = current_user
        @sinistre = Sinistre.new
        @evaluation = Evaluation.new
        respond_to do |format|
            format.html { render :show }
            format.js
        end
    end

    # GET /locataires/new
    def new
        @locataire = Locataire.new
    end

    # GET /locataires/1/edit
    def edit; end

    # POST /locataires
    # POST /locataires.json
    def create
        @locataire = Locataire.new(locataire_params)
        @locataire.user = current_user
        respond_to do |format|
            if @locataire.save
                format.html { redirect_to user_path(current_user), notice: 'Votre locataire est bien crée.' }
                format.json { render :show, status: :created, location: @locataire }
            else
                format.html { render :new }
                format.json { render json: @locataire.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /locataires/1
    # PATCH/PUT /locataires/1.json
    def update
        respond_to do |format|
            if @locataire.update(locataire_params)
                format.html { redirect_to user_path(current_user), notice: 'Votre locataire à bien modifier.' }
                format.json { render :show, status: :ok, location: @locataire }
            else
                format.html { render :edit }
                format.json { render json: @locataire.errors, status: :unprocessable_entity }
            end
        end
    end


    private


    def authorize_plan
      redirect_to pricing_path, alert: 'Vous n\'avez aucun abonnement.' unless current_user.role == "Proprietaire" && current_user.subscription.try(:plan) != nil
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_locataire
        @locataire = Locataire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def locataire_params
        params.require(:locataire).permit(:firstname, :lastname, :email, :street, :zip_code, :city, :address, :fiabilite_pers, :sinistralite_pers, :montant_loyer, :revenus, :situation_pro, :situation_fam, :age_birth)
    end
end
