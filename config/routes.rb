Gallery::Application.routes.draw do

  get '/auth/:provider/callback' => 'facebook#create'
  post 'admin/parse' => 'admin/parse#ex' # for parsing

  devise_for :users, :controllers => {:registrations => "registrations",:sessions => "sessions"}
  get '/event/:user_id/sign_in'       => 'events#show', :as => 'event_sign_in'
  get '/event/:user_id/sign_out'      => 'events#show', :as => 'event_sign_out'
  get '/event/:user_id/navigation'    => 'events#show', :as => 'event_navigation'
  get '/event/:user_id/like'          => 'events#show', :as => 'event_like'
  get '/event/:user_id/comment'       => 'events#show', :as => 'event_comment'



  resources :categories, only: [:show, :index]
  resources :events, only: [:show, :index]
  resources :likes, only: [:create]
  resources :subscribes, only: [:create]
  resources :images, only: [:index, :show] do
    resources :comments, only: [:new, :create]
  end
  root :to => 'images#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end
