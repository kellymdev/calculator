# frozen_string_literal: true

class BasicCalculatorsController < ApplicationController
  before_action :find_calculator, only: :show

  def index
    @calculator = BasicCalculator.new
    @calculators = BasicCalculator.all
  end

  def create
    @calculator = BasicCalculator.create!

    redirect_to @calculator
  end

  def show
    @calculation = @calculator.calculations.new
  end

  private

  def find_calculator
    @calculator = BasicCalculator.find params[:id]
  end
end
