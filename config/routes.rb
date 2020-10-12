Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create, :update]

      post :auth, to: 'authentication#authenticate'
    end
  end
end
