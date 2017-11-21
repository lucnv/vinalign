Rails.application.routes.draw do
  devise_for :users

  root "pages#show", page: :home
  get "pages/:page", to: "pages#show", as: :page  

  namespace :admin do 
    root "homes#index"
    resources :homes, only: :index
  end
end
