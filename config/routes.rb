Rails.application.routes.draw do
  devise_for :users
  root 'files#index'
end
