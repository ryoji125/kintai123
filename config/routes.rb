Rails.application.routes.draw do
  get 'staticpages/home'
  root 'staticpages#home'
end
