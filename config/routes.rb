Rails.application.class.routes.draw do

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'home' => 'profiles#home', :as => :user_profile
  match 'account/settings' => 'users#settings', :as => :account_settings

  match 'account/email' => 'users#email', :as => :account_email
  match 'validate_email/:id' => "users#validate_email", :as => "validate_email"

  resources :users
  resources :user_sessions
  resources :administrators

end
