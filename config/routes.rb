Rails.application.routes.draw do

  resources :comics
  resources :comments, only: [:new, :create]
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"
  root "comics#index"
end
