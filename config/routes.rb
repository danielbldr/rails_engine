Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
        namespace :items do
          get '/find', to: 'search#show'
          get '/find_all', to: 'search#index'
        end
        namespace :merchants do
          get '/most_revenue', to: 'revenue#index'
          get '/most_items', to: 'merchant_items#index'
          get '/find', to: 'search#show'
          get '/find_all', to: 'search#index'
        end
      resources :items, except: %I[new, edit] do
        scope module: :items do
          resources :merchant, only: [:index]
        end
      end
      resources :merchants, except: %I[new, edit] do
        scope module: :merchants do
          resources :items, only: [:index]
        end
      end
    end
  end
end
