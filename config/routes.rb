S3Upload::Application.routes.draw do

  resources :albums do
    get 'page/:page', :action => :show, :on => :member
    resources :images, only: [:create, :destroy]
  end

  root to: "home#index"
  devise_for :users
end
