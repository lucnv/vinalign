Rails.application.routes.draw do
  devise_for :users

  root "pages#show", page: :home
  get "pages/:page", to: "pages#show", as: :page  

  namespace :supports do 
    resources :districts, ony: :index
  end

  namespace :admin do 
    root "homes#index"
    resources :homes, only: :index
    resources :patient_records, only: [:index, :show] do 
      resources :price_lists, only: [:index, :new, :create]
    end
    resources :price_lists, only: [:edit, :update, :destroy]
  end

  namespace :clinic do 
    root "patient_records#index"
    resources :patient_records, except: :destroy do 
      resources :price_lists, only: :index
    end
  end
end
