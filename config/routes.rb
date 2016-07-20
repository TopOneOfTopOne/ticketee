Rails.application.routes.draw do

  devise_for :users
  root 'projects#index'

  resources :projects, except: [:create, :new, :destroy] do
    resources :tickets
  end

  namespace :admin do
    root "application#index"

    resources :projects, only: [:create, :new, :destroy]
    resources :users do
      member do
        patch :archive
      end
    end
  end

  resources :attachments, only: [:show, :new]
end
