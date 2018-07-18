require 'rails_helper'

RSpec.describe CalculatorsController, type: :controller do
  describe '#new' do
    it 'returns http status 200' do
      get :new

      expect(response.status).to eq 200
    end
  end
end
