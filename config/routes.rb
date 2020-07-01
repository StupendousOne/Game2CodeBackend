Rails.application.routes.draw do
  resources :scores
  resources :feeds
  resources :challenges
  resources :follows
  resources :friends
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/login', to: 'sessions#create'
  post '/signup', to: 'users#create'
  patch '/friend', to: 'user_friends#update'
end
