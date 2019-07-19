Rails.application.routes.draw do
  get 'sessions/new'
  root 'staticpages#home'
  get "/signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "edit_basic_info/:id", to: "users#edit_basic_info", as: :basic_info
  patch "update_basic_info", to: "users#update_basic_info"
  get "users/:id/attendances/:date/edit", to: "attendances#edit", as: :edit_attendances
  patch 'users/:id/attendances/:date/update', to: 'attendances#update', as: :update_attendances
  get "go_work", to: "users#go_work", as: :go_work
  delete "bases/:id", to: "bases#destroy", as: :destroy_base
  get "users/:id/attendances/:id/index", to: "attendances#edit_work", as: :edit_work
  patch "users/:id/attendances/:id/update_work", to: "attendances#update_work", as: :update_work
  resources :bases do
    member do
      get 'edit'
      patch 'update'
    end
  end
  resources :users do
    resources :attendances do
      member do
        get  "edit_overwork"
        patch "update_overwork"

      end
    end
    collection { post :import }
  end
end
