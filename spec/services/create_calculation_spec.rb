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
  end
end
