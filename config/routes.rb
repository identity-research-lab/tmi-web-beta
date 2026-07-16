Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "use_cases" => "static_pages#use_cases"
  get "contribute" => "static_pages#contribute"
  get "contact" => "static_pages#contact"

  resources :categories
  resources :code_metrics
  resources :codes
  resources :journals, only: [:show]
  resources :memos
  resources :personas, except: [:destroy]
  resources :projects, except: [:destroy]
  resources :searches, except: [:destroy, :update]
  resources :survey_items, except: [:destroy]

end
