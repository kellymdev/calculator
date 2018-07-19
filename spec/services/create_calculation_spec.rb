require 'rails_helper'

RSpec.describe CreateCalculation, type: :service do
  describe '#call' do
    let(:calculator) { BasicCalculator.create! }
    let(:service) { CreateCalculation.new(calculator, { equation: equation }) }

    context 'with a valid equation' do
      context 'using +' do
        let(:equation) { '1+2' }

        it 'adds the two numbers together' do
          expect(service.call).to eq 3
        end
      end

      context 'using -' do
        let(:equation) { '1-2' }

        it 'subtracts the two numbers' do
          expect(service.call).to eq -1
        end
      end

      context 'using *' do
        let(:equation) { '1*2' }

        it 'multiplies the two numbers' do
          expect(service.call).to eq 2
        end
      end

      context 'using /' do
        let(:equation) { '1/2' }

        it 'divides the two numbers' do
          expect(service.call).to eq 0.5
        end
      end
    end

    context 'with an invalid equation' do
      context 'when the equation is too short' do
        let(:equation) { '12' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation is too short (minimum is 3 characters), Equation must contain one of +, -, * or /, and Equation must contain a number either side of an operator'
        end
      end

      context 'when the equation contains only a number' do
        let(:equation) { '123' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain one of +, -, * or / and Equation must contain a number either side of an operator'
        end
      end

      context 'when the equation is missing the first number' do
        let(:equation) { '+12' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain a number either side of an operator'
        end
      end

      context 'when the equation is missing the second number' do
        let(:equation) { '12+' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain a number either side of an operator'
        end
      end

      context 'when the equation contains a letter' do
        let(:equation) { 'a+2' }

        it 'creates an error on the service' do
          service.call

          expect(service.errors.full_messages.to_sentence).to eq 'Equation must contain a number either side of an operator'
        end
      end
    end
  end
end
