require 'rails_helper'

RSpec.describe BasicCalculatorsController, type: :controller do
  describe '#index' do
    it 'returns http status 200' do
      get :index

      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    it 'creates a calculator' do
      expect { post :create }.to change { BasicCalculator.count }.by 1
    end

    it 'redirects to the calculator' do
      post :create

      expect(response).to redirect_to BasicCalculator.last
    end
  end

  describe '#show' do
    let!(:calculator) { BasicCalculator.create! }

    it 'returns http status 200' do
      get :show, params: { id: calculator.to_param }

      expect(response.status).to eq 200
    end
  end

  describe '#update_memory' do
    let!(:calculator) { BasicCalculator.create!(memory: 5) }
    let!(:calculation) { calculator.calculations.create!(equation: '1+2', answer: 3) }

    context 'for M+' do
      let(:commit) { UpdateCalculatorMemory::MEMORY_PLUS }
      let(:params) do
        {
          id: calculator.to_param,
          commit: commit
        }
      end

      it 'calls the UpdateCalculatorMemory service' do
        expect(UpdateCalculatorMemory).to receive(:new).with(calculator, commit).and_call_original

        post :update_memory, params: params
      end

      it 'adds the previous calculation value to the memory' do
        post :update_memory, params: params

        expect(calculator.reload.memory).to eq 8
      end
    end

    context 'for M-' do
      let(:commit) { UpdateCalculatorMemory::MEMORY_MINUS }
      let(:params) do
        {
          id: calculator.to_param,
          commit: commit
        }
      end

      it 'calls the UpdateCalculatorMemory service' do
        expect(UpdateCalculatorMemory).to receive(:new).with(calculator, commit).and_call_original

        post :update_memory, params: params
      end

      it 'subtracts the previous calculation value from memory' do
        post :update_memory, params: params

        expect(calculator.reload.memory).to eq 2
      end
    end
  end
end
