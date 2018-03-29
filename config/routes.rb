Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => "/cable"
  devise_for :users

  root "pages#show", page: :home
  get "pages/:page", to: "pages#show", as: :page

  namespace :supports do
    resources :districts, ony: :index
    resources :notifications, only: [:index, :update]
  end

  namespace :admin do
    root "clinics#index"
    resources :homes, only: :index
    resources :clinics do
      resources :patient_records, only: [:index, :new, :create]
    end
    resources :users, only: [:index, :new, :create]
    resources :patient_records, except: [:index, :new, :create] do
      resources :price_lists, only: [:index, :new, :create]
      resources :treatment_phases, only: [:index, :new, :create]
    end
    resources :price_lists, only: [:edit, :update, :destroy]
    resources :treatment_phases, only: :show do
      resources :treatment_plan_files, only: :create
      resources :albums, only: [:new, :create]
    end
    resources :albums, only: [:edit, :update, :destroy]
    resources :experts
    resources :articles
    resources :treatment_phases, only: [:edit, :update, :destroy]
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
    resources :treatment_phases, only: [:edit, :update, :destroy]
  end

  namespace :my_page do
    resources :notifications, only: :index
    resource :profile, only: :show
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

  resources :experts, only: :index
  resources :articles, only: :show
  get ":category", to: "category/articles#index", as: "category_articles"
end
