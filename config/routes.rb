Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  scope "(:locale)", :locale => /en|ru/ do
    devise_for :users
    root 'files#index'
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
  get '/dropbox_auth', to: redirect('/dropbox_auth.html')
end
