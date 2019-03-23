Rails.application.routes.draw do
  get "/sigunup" => "users#new"
  get 'staticpages/home'
  root 'staticpages#home'
end
