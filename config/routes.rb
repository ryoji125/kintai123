Rails.application.routes.draw do
  root 'staticpages#home'
  get "/signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
end
