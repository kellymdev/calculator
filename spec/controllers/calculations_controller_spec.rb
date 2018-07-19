require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let(:calculator) { BasicCalculator.create! }

  describe '#create' do
    let(:params) do
      {
        calculator_id: calculator.to_param,
        calculation: {
          equation: equation
        }
      }
    end

    context 'with valid params' do
      let(:equation) { '1+2' }

      it 'calls the CreateCalculation service' do
        expect(CreationCalculation).to receive(:new).with(calculator, { equation: equation })

        post :create { params: params }
      end
    end
  end
end
