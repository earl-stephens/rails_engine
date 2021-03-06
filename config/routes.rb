Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'most_revenue', to: 'most_revenue#index'
        get 'most_items', to: 'most_items#index'
        get 'revenue', to: 'revenue#show'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'search#show'
      end
      namespace :items do
        get 'most_revenue', to: 'most_revenue#index'
        get 'most_items', to: 'most_items#index'
        get 'find', to: 'search#show'
      end
      resources :merchants, only: [:index, :show] do
        get 'favorite_customer', to: 'favorite_customer#show'
        get 'revenue', to: 'revenue#show'
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show] do
        get 'favorite_merchant', to: 'favorite_merchant#show'
      end
      resources :invoice_items, only: [:index, :show]
    end
  end

end
