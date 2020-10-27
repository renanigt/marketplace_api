Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create, :update, :destroy] do
        get '/products', to: 'products#list'
      end
      resources :products, only: [:index, :create, :show, :update, :destroy]
      resources :orders, only: [:index, :show, :create]

      post :auth, to: 'authentication#authenticate'
    end
  end
end
