Rails.application.routes.draw do
  get 'search/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  devise_for :users
  get "/books/search" => "books#search"
  get "/books/order_by" => "books#order_by"
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    get "/follow" => "users#follow"
    get "/follower" => "users#follower"
    resource :relationships, only: [:create, :destroy]
    resource :rooms, only: [:show]
  end
  resources :groups do
    resource :group_users, only: [:create, :destroy]
    resource :event_mails, only: [:new, :create]
  end

  get "/search_number_of_books" => "users#search_number_of_books"
  post ":room_id/message" => "messages#create"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end