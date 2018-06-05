class ComparaisonsController < ApplicationController
  before_action :authorize_plan_2

  def new
    @comparaison = Comparaison.new
  end

  def create
    @comparaison = Comparaison.new(comparaisons_params)
    @comparaison.user = current_user
    @comparaison.save
    respond_to do |format|
      format.js
    end
  end

  def comparaison_profils
    @comparaison = Comparaison.new
    @evaluation = Evaluation.new
    @locataire = Locataire.new
  end


  private


  def authorize_plan_2
    unless current_user.role == "Proprietaire" and current_user.subscription.try(:plan) == Plan.find(2)
      redirect_to pricing_path, alert: 'Passez au PLAN STANDARD pour bénéficier de la comparaison de profils.'
    end
  end

  def comparaisons_params
    params.require(:comparaison).permit(:edp_loyerf, :edp_revenus_mensuelsf, :edp_situation_familialef, :edp_year_birthf, :edp_contrat_travailf, :edp_cityf, :edp_loyerl, :edp_revenus_mensuelsl, :edp_situation_familialel, :edp_year_birthl, :edp_contrat_travaill, :edp_cityl)
  end
end
