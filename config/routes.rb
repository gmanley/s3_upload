S3Upload::Application.routes.draw do
  root to: 'home#index'

  resources :albums do
    get 'page/:page', action: :show, on: :member
    resources :images, only: [:create, :destroy]
  end

  resources :users do
    get :activate, on: :member
  end

  resources :user_sessions
  resources :password_resets

  match 'login' => 'user_sessions#new', as: :login
  match 'logout' => 'user_sessions#destroy', as: :logout
end
