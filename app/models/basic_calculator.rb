class BasicCalculator < ApplicationRecord
  has_many :calculations

  def previous_calculation
    calculations.order(:created_at).last
  end
end
