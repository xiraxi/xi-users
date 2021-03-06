Rails.application.class.routes.draw do

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'home' => 'users#home', :as => :user_profile

  match 'account/request_reset_password' => 'users#request_reset_password', :as => :request_reset_password
  match 'account/reset_password/:id' => 'users#reset_password', :as => :reset_password

  match 'account/settings' => 'users#settings', :as => :account_settings
  match 'account/password' => 'users#change_password', :as => :change_password
  match 'account/email' => 'users#email', :as => :account_email
  match 'validate/email/:id' => "users#validate_email", :as => :validate_email_change
  match 'validate/account/:id' => "users#validate_account", :as => :validate_account

  match 'users/recent' => 'users#index', :order => "last_login", :as => "recent_users"
  match 'users/connected' => 'users#index', :order => "connected", :as => "connected_users"

  resources :users do
    member do
      get :confirm_remove
    end
  end

  match '/admin/everything' => "admin#index", :as => "admin_index"

  resources :user_sessions

  scope "admin" do
    namespace :user do
      resources :administrators
      resources :validation_pending_users do
        member do
          post :validate
        end
      end
    end
  end

  if Rails.env.test?
    match "root" => "users#index"
  end
end
