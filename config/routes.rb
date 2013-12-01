JaffaChat::Application.routes.draw do

  get "openfire/add_user"

  resources :conversations

  resources :library_sets

  resources :rooms do
    member do
      post 'add_message'
      post 'empty'
      get 'messages'
    end
  end


  devise_for :users,:controllers => { :registrations => :'api/user_registrations', :sessions=>'api/user_sessions' }

  match 'profile' => 'users#profile', :as => :profile

  match 'search' => 'search#index', :as => :search
  match 'chat' => 'chat#index', :as => :chat
  match 'search_engines' => 'search_engines#index', :as => :search_engines
  match 'search_engines/apply/:engine' => 'search_engines#apply', :as => :search_engine_apply

  resources :sayings

  resources :clips do
    collection do
      post 'reindex'
    end
  end

  resources :libraries do
    member do
      post 'add_clip_from_url', :as => :add_clip_from_url
    end
  end

  root :to => 'libraries#index'

end
