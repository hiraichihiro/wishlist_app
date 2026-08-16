Rails.application.routes.draw do
  # ルートパスを wishes#index に設定
  root 'wishes#index'
  
  # Wishes のルーティング(RESTful)
  resources :wishes do
    # Wishes に紐づく Savings のルーティング
    resources :savings, only: [:new, :create, :destroy]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
