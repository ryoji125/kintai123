Rails.application.routes.draw do
  root 'staticpages#home'
  get "/signup" => "users#new"
  resources :users
end
