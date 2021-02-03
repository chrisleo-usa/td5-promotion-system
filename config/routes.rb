Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :promotions, only: [:index, :show, :new, :create] do 
    post 'generate_coupons', on: :member  #mesma coisa do código abaixo, mas este é o jeito Padrão
  end

  resources :categories, only: [:index, :new, :create, :show]
  # post '/promotions/:id/generate', to: 'promotions#generate_coupons'
end
