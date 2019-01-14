Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post :edit_establishments
        end
      end
      resources :establishments
      resources :visits
      post '/checkIn', to:'visits#create'
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      post '/mapSearch', to: 'establishments#search'
    end
  end
end
