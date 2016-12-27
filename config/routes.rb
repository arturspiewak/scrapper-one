Rails.application.routes.draw do
  resources :saxes, only: [ :index, :new, :create, :show ]
  root to: "saxes#index"
end
