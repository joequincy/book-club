Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'welcomes#index'

  resources :books, only: [:index, :show, :new, :create, :destroy] do
    resources :reviews, only: [:new, :create]
  end
  resources :authors, only: [:show, :destroy]
  resources :reviews, only: [:new, :create, :destroy]

  resources :users, only: [:show]
end
