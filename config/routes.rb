Rails.application.routes.draw do
  devise_for :users
  root 'files#index'
  resources :files, only: [] do
    collection do
      post 'upload'
    end
  end
end
