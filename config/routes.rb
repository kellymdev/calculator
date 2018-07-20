Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'basic_calculators#index'

  resources :basic_calculators, only: [:index, :create, :show] do
    resources :calculations, only: [:create]
  end

  post 'basic_calculators/:id/update_memory', to: 'basic_calculators#update_memory', as: :basic_calculator_update_memory
end
