Rails.application.routes.draw do
  devise_for :users
  root 'files#index'
  resources :files, only: [:index] do
    collection do
      post 'upload'
    end
  end
  resources :extensions, only: [:index]
  resources :users, only: [] do
    collection do
      get 'files_history'
    end
  end
end
