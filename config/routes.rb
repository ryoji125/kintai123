Rails.application.routes.draw do
  root 'staticpages#home'
  get "/signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "edit_basic_info/:id" => "users#edit_basic_info", as: :basic_info
  patch "update_basic_info" => "users#update_basic_info"
  resources :users do
    resources :attendances, only: :create
  end
end
