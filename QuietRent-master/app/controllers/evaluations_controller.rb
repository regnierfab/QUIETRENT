class EvaluationsController < ApplicationController
  def new
    @evaluation = Evaluation.new
  end

  def create
    @evaluation = Evaluation.new(evaluations_params)
    @evaluation.user = current_user
    @evaluation.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @evaluation = Evaluation.find(params[:id])
    @evaluation.update(evaluations_params)
  end

  private

  def evaluations_params
    params.require(:evaluation).permit(:edp_loyer, :edp_revenus_mensuels, :edp_situation_familiale, :edp_year_birth, :edp_contrat_travail, :edp_city)
  end
end
