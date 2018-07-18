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
end
