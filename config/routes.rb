Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'

  resources :books do
    resources :likes, only: [:create, :destroy]
    resources :book_comments, only: [:create]
  end
  resources :posts do
    resources :post_likes, only: [:create, :destroy]
    resources :post_comments, only: [:create]
  end

  root 'hello#index'
end
