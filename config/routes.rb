Rails.application.routes.draw do
  get 'studies/index'
  devise_for :users
  resources :studies, only: [:index, :new]
  root to: "studies#index"
end
