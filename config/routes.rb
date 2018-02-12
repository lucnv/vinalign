Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  devise_for :users

  root "pages#show", page: :home
  get "pages/:page", to: "pages#show", as: :page

  namespace :supports do
    resources :districts, ony: :index
  end

  namespace :admin do
    root "clinics#index"
    resources :homes, only: :index
    resources :clinics, only: [:index, :show, :new, :create] do
      resources :patient_records, only: :index
    end
    resources :users, only: [:index, :new, :create]
    resources :patient_records, only: :show do
      resources :price_lists, only: [:index, :new, :create]
      resources :treatment_phases, only: [:index, :new, :create]
    end
    resources :price_lists, only: [:edit, :update, :destroy]
    resources :treatment_phases, only: :show do
      resources :treatment_plan_files, only: :create
    end
    resources :experts, except: :show
  end

  namespace :clinic_management do
    root "patient_records#index"
    resources :patient_records do
      resources :price_lists, only: :index
      resources :treatment_phases, only: [:index, :new, :create]
    end
    resources :treatment_phases, only: :show do
      resources :albums, only: [:new, :create]
    end
    resources :albums, only: [:edit, :update, :destroy]
  end

  resources :albums do
    resources :images, only: [:index, :create]
  end

  resources :treatment_phases do
    resources :messages, only: :create
  end

  namespace :download do
    resources :treatment_plan_files, only: :show
  end
end
