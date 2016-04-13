Rails.application.routes.draw do
  devise_for :users
  root 'files#index'
  resources :files, only: [:index] do
    collection do
      post 'upload'
    end
  end
  resources :formats, only: [:index]
end
