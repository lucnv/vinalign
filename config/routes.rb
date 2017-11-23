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
  end

  namespace :clinic do 
    root "pages#show", page: :home
    resources :patient_records, only: [:new, :create]
  end
end
