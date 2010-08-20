Rails.application.class.routes.draw do

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'home' => 'users#home', :as => :user_profile

  match 'account/settings' => 'users#settings', :as => :account_settings
  match 'account/password' => 'users#change_password', :as => :change_password
  match 'account/email' => 'users#email', :as => :account_email
  match 'validate/email/:id' => "users#validate_email", :as => "validate_email_change"

  resources :users
  resources :user_sessions
  resources :administrators

end
