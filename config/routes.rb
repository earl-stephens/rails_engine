Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/v1/merchants/most_revenue', to: 'api/v1/merchants/most_revenue#index'
  get '/api/v1/merchants/most_items', to: 'api/v1/merchants/most_items#index'
  get '/api/v1/merchants/revenue', to: 'api/v1/merchants/revenue#show'
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end

end
