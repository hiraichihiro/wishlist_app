Rails.application.routes.draw do
  root 'wishes#index'
  
  resources :wishes do
    collection do
      get :fulfilled # 達成リスト画面用
    end
    member do
      patch :toggle_fulfill # 達成/未達成切り替え用
    end
    resources :savings, only: [:new, :create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end