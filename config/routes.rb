Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'home/about' => 'homes#about', as: 'about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books #,only: [:index, :show, :create, :edit, :update, :destroy]
  #get "homes/about", to: "homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
