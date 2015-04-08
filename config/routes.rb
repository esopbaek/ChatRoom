Rails.application.routes.draw do
  root 'sessions#new'
  
  resource :session, only: [:create, :destroy, :new]
  resources :users, only: [:create, :new, :show, :destroy]
  resources :groups, only: [:create, :new, :show, :destroy]
end
