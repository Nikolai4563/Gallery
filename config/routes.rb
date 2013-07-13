Gallery::Application.routes.draw do

  get '/auth/:provider/callback' => 'facebook#create'
  get '/auth/destroy' => 'facebook#destroy'
  post 'admin/parse' => 'admin/parse#ex' # for parsing

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :categories, only: [:show, :index]
  resources :likes, only: [:create]
  resources :images, only: [:index] do
    resources :comments, only: [:new, :create]
  end
  root :to => 'images#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end
