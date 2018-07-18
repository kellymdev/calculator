Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'basic_calculators#index'

  resources :basic_calculators, only: [:index, :create, :show] do
    resources :calculations, only: [:create]
  end
end
