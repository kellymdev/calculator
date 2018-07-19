require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let(:calculator) { BasicCalculator.create! }

  describe '#create' do
    let(:params) do
      {
        basic_calculator_id: calculator.to_param,
        calculation: {
          equation: equation
        }
      }
    end

    context 'with valid params' do
      let(:equation) { '1+2' }

      it 'calls the CreateCalculation service' do
        expect(CreateCalculation).to receive(:new).with(calculator, equation).and_call_original

        post :create, { params: params }
      end
    end

    context 'with invalid params' do
      let(:equation) { '3+' }

      it 'calls the CreateCalculation service' do
        expect(CreateCalculation).to receive(:new).with(calculator, equation).and_call_original

        post :create, { params: params }
      end

      it 'creates a flash error' do
        post :create, { params: params }

        expect(flash[:error]).to eq 'Equation is too short (minimum is 3 characters) and Equation must contain a number either side of an operator'
      end
    end
  end
end
