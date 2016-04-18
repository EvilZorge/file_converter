Rails.application.routes.draw do
  devise_for :users
  root 'files#index'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :files, only: [:index] do
    collection do
      post 'upload'
      get  'file_info'
      get  'check_state'
    end
  end
  resources :extensions, only: [:index]
  resources :users, only: [] do
    collection do
      get 'files_history'
    end
  end
end
