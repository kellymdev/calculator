class BasicCalculator < ApplicationRecord
  has_many :calculations, dependent: :destroy

  def previous_calculation
    calculations.order(:created_at).last
  end
end
