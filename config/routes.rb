Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  resources :saxes, only: [ :index, :new, :create, :show ]
  root to: "saxes#index"
end
