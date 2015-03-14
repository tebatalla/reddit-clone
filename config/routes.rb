Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:new]
  end
  resources :posts, except: [:index, :destroy, :new] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]
end
