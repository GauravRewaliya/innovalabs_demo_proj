Rails.application.routes.draw do
  get 'users/register_view'
  get 'users/login_view'
  post 'users/register' , to: "users#register" 
  post 'users/login' , to: "users#login" 
  post 'users/logout' , to: "users#logout" 
  resources :posts ,only: [:index ,:new ,:create , :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#login_view"
end
