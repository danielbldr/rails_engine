Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, except: %I[new, edit]
      resources :merchants, only: [:index, :show, :create]
    end
  end
end
