require 'rails_helper'

RSpec.describe BasicCalculator, type: :model do
  describe '#previous_calculation' do
    let(:calculator) { BasicCalculator.create! }

    context 'when there are no calculations' do
      it 'returns nil' do
        expect(calculator.previous_calculation).to eq nil
      end
    end

    context 'when there is a single calculation' do
      let!(:calculation) do
        calculator.calculations.create!(
          equation: '1+2',
          answer: 3
        )
      end

      it 'returns the calculation' do
        expect(calculator.previous_calculation).to eq calculation
      end
    end

    context 'when there is more than one calculation' do
      let!(:calculation_1) do
        calculator.calculations.create!(
          equation: '1+1',
          answer: 2
        )
      end
      let!(:calculation_2) do
        calculator.calculations.create!(
          equation: '2+2',
          answer: 4
        )
      end

      it 'returns the most recent calculation' do
        expect(calculator.previous_calculation).to eq calculation_2
      end
    end
  end
end
