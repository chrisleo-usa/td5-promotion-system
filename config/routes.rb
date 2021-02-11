Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  get 'search', to: 'home#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :promotions, only: [:index, :show, :new, :create, :edit, :update, :destroy] do 
    member do
      post 'generate_coupons'
      post 'approve'
    end
  end

  resources :coupons, only: [] do
    member do 
      post 'disable'
      post 'enable'
    end
  end

  resources :categories, only: [:index, :new, :create, :show, :edit, :update]
  # post '/promotions/:id/generate', to: 'promotions#generate_coupons'
end
