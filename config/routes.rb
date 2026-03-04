Rails.application.routes.draw do
  get "home/index"
  get "invitations/new"
  resources :organizations do
    resources :properties do
        resources :issues do
          resources :comments
          member do
            patch :update_status
          end
        end
      resources :invitations, only: [:new, :create]
    end
    resources :members
    resources :invitations, only: [:new, :create]
  end
  get "dashboard" => 'dashboard#home'
  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end
  
  resources :users
  get "signup" => "users#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  get "verify_email", to: "users#verify_email", as: 'verify_email'
  post "resend_verification", to: "users#resend_verification", as: :resend_verification
  get "/invitations/accept", to: "invitations#accept", as: :accept_invitation
  root "home#index"
end
