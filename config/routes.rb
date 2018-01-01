Rails.application.routes.draw do

  resources :comics
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"
  root "comics#index"
end
