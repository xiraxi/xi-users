Rails.application.class.routes.draw do

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'home' => 'profiles#home', :as => :user_profile

  resources :users
  resources :user_sessions
  resources :administrators

end
