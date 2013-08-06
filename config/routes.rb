CustomerFirst::Application.routes.draw do

  match "/companies/:id/users" => "site#company_users", :as => :company_users
  match "/users_dashboard/show", :as => :users_dashboard
  get "/contacts/import"
  post "/contacts/import" => "contacts#new"

  resources :activities
  resources :companies
  resources :subscriptions
  resources :relations do
    member do
      get :relationdata
    end
  end

  resources :contacts do
    member do
      get :contactdata
    end
  end

  resources :notes
  resources :tasks
  resources :agreements
  resources :dossiers
  resources :sessions
  resources :users

  # Support
  resources :countries
  resources :dossier_statuses
  resources :branches
  resources :sectors
  resources :tasktypes
  resources :rel_types

  get "ins_insurances/settings"
  resources :ins_insurances
  resources :ins_branches
  resources :ins_types
  resources :ins_markets
  resources :ins_insurers
  resources :emp_employees

  # Misc
  match "/contacts/vcard_export/:id" => "contacts#vcard_export"

  get "site/index", :as => "public_home"
  post "site/index"
  get "site/support"
  get "site/dashboard", :as => "dashboard"

  get "users_dashboard/show", :as => "users_dashboard"

  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  # Site root for general visitors
  root :to => 'sessions#new'

end