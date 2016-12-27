Rails.application.routes.draw do
  resources :saxes, only: [ :index, :new, :create ]
  root to: "saxes#index"
end
