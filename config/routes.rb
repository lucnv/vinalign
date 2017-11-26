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
      resources :treatment_phases, only: [:index, :new, :create]
    end
    resources :price_lists, only: [:edit, :update, :destroy]
    resources :treatment_phases, only: :show
  end

  namespace :clinic do 
    root "patient_records#index"
    resources :patient_records, except: :destroy do 
      resources :price_lists, only: :index
      resources :treatment_phases, only: [:index, :new, :create]
    end
    resources :treatment_phases, only: :show do 
      resources :albums, only: [:new, :create]
    end
  end

  resources :albums do 
    resources :images, only: [:index, :create]
  end

  resources :treatment_phases do 
    resources :messages, only: :create
  end
end
