Rails.application.routes.draw do
  get 'studies/index'
  devise_for :users
  resources :studies
  resources :recalls, only: [] do
    member do
      patch :complete
    end
  end
  root to: "studies#index"
end
