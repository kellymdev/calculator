# frozen_string_literal: true

class CalculationsController < ApplicationController
  before_action :find_calculator, only: :create

  def create
    service = CreateCalculation.new(@calculator, calculation_params).call

    redirect_to basic_calculator_path(@calculator)
  end

  private

  def find_calculator
    @calculator = BasicCalculator.find params[:basic_calculator_id]
  end

  def calculation_params
    params.require(:calculation).permit(:equation)
  end
end
