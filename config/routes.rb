Rails.application.routes.draw do
  get 'users/register'
  get 'users/login'
  resources :posts ,only: [:index ,:new ,:create , :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
