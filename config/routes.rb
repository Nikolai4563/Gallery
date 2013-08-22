Gallery::Application.routes.draw do

  get '/auth/:provider/callback' => 'facebook#create'

  post 'admin/parse' => 'admin/parse#ex' # for parsing

  devise_for :users, :controllers => {:registrations => "registrations",:sessions => "sessions"}
  #get '/event/:user_id/sign_in'       => 'events#show', :as => 'event_sign_in'
  #get '/event/:user_id/sign_out'      => 'events#show', :as => 'event_sign_out'
  #get '/event/:user_id/navigation'    => 'events#show', :as => 'event_navigation'
  #get '/event/:user_id/like'          => 'events#show', :as => 'event_like'
  #get '/event/:user_id/comment'       => 'events#show', :as => 'event_comment'
  resources :events, only: [:index] do
    collection do
      get '/navigation/:user_id' => 'events#navigation', as: 'navigation'
      get '/sign_in/:user_id' => 'events#sign_in', as: 'sign_in'
      get '/sign_out/:user_id' => 'events#sign_out', as: 'sign_out'
      get '/like/:user_id' => 'events#like', as: 'like'
      get '/comment/:user_id' => 'events#comment', as: 'comment'
    end
  end


  resources :categories, only: [:show, :index]
  resources :likes, only: [:create]
  resources :subscribes, only: [:create]
  resources :images, only: [:index, :show] do
    resources :comments, only: [:new, :create]
    collection do
      match 'search' => 'images#search', :via => [:get, :post], :as => :search
    end
  end
  root :to => 'images#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Resque::Server, :at => '/resque'
  mount FnordMetric::WebSocket.new => "/fnordmetric/stream"
  #mount FnordMetric::WebSocket.new => "/fnordmetric/stream"
  mount FnordMetric::App => "/fnordmetric"
end