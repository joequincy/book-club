Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'welcomes#index'

  resources :books, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end
  resources :authors, only: [:show]
  resources :reviews, only: [:new, :create]

  resources :users, only: [:show]
end
