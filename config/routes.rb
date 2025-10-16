Rails.application.routes.draw do
  root "contacts#index"
  
  resources :contacts, only: [:index]
  
  resources :email_templates do
    member do
      get :preview
      post :send_email
    end
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end
