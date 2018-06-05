class UsersController < EvaluationsController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_admin, only: :gestion_parc
  before_action :authorize_plan, only: [:show, :update]
  def show
    # unless @user == current_user
    # redirect_to root_path, :alert => "Accès refusé."
    # end
    @evaluation = Evaluation.new
    @locataires = Locataire.where(user: current_user)
    @locataire = Locataire.new
    @first_results = params[:search]
    @second_results = params[:search_show]
    @results = @locataires.global_search(@first_results)
    @result = @results.first
    @results_show = @locataires.global_search(@second_results)
    @result_show = @results_show.first
    @user.calculate_fiabilite_global
  #   if @user.fiabilites.last != nil
  #     if Date.today.day == 26 && @user.fiabilites.last.date_fiabilite != Date.today
  #       @user.save_fiabilite
  #   end
  # end
    respond_to do |format|
      format.html { render :show}
      format.js
    end
  end

  def gestion_parc
    @evaluation = Evaluation.new
    @locataire = Locataire.new
  end


  def update
      # authorize! :update, @user
      respond_to do |format|
        if @user.update(user_params)
          sign_in(@user == current_user ? @user : current_user, :bypass => true)
          format.html { redirect_to informations_import_locataires_path, notice: 'Votre entreprise a été créer avec succès.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end

      end
    end

private

    def authorize_admin
      redirect_to root_path, status: 401 unless current_user.admin
      flash[:alert] = "Access interdit!"
    end

    def authorize_plan
      redirect_to pricing_path, alert: 'Vous n\'avez aucun abonnement.' unless current_user.role == "Proprietaire" && current_user.subscription.try(:plan) != nil
    end

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:denomination, :address)
    end


end
