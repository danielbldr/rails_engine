Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
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
