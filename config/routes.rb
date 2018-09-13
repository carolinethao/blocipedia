Rails.application.routes.draw do
  get 'users/premium_to_standard'

  resources :wikis
  resources :charges, only: [:new, :create]
  resources :users, only: [] do
     post 'premium_to_standard' => 'users#premium_to_standard', as: :premium_to_standard
end
  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
