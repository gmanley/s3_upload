S3Upload::Application.routes.draw do

  authenticated do
    root to: "albums#index"
  end

  root to: "home#index"

  resources :albums do
    get 'page/:page', :action => :show, :on => :member
    resources :images, only: [:create, :destroy]
  end

  devise_for :users
end
