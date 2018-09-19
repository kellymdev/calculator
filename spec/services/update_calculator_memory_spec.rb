require 'rails_helper'

RSpec.describe UpdateCalculatorMemory, type: :service do
  describe '#call' do
    let!(:calculator) { BasicCalculator.create! }

    let(:service) { described_class.new(calculator, action) }

    context 'for M+' do
      let(:action) { 'M+' }

      context 'when there is not a previous calculation' do
        it 'sets the memory to 0' do
          service.call

          expect(calculator.reload.memory).to eq 0
        end
      end

      context 'when there is a previous calculation' do
        let!(:calculation) { calculator.calculations.create!(equation: '1+2', answer: 3) }

        context 'when the memory is empty' do
          it 'adds the previous calculation answer to the memory' do
            service.call

            expect(calculator.reload.memory).to eq 3
          end
        end

        context 'when the memory has a value' do
          before do
            calculator.update!(memory: 5)
          end

          it 'adds the previous calculation answer to the memory' do
            service.call

            expect(calculator.reload.memory).to eq 8
          end
        end
      end
    end

    context 'for M-' do
      let(:action) { 'M-' }

      context 'when there is not a previous calculation' do
        it 'sets the memory to 0' do
          service.call

          expect(calculator.reload.memory).to eq 0
        end
      end

      context 'when there is a previous calculation' do
        let!(:calculation) { calculator.calculations.create!(equation: '1+2', answer: 3) }

        context 'when the memory is empty' do
          it 'subtracts the previous calculation answer from the memory' do
            service.call

            expect(calculator.reload.memory).to eq -3
          end
        end

        context 'when the memory has a value' do
          before do
            calculator.update!(memory: 5)
          end

          it 'subtracts the previous calculation answer from the memory' do
            service.call

            expect(calculator.reload.memory).to eq 2
          end
        end
      end
    end
  end
end
