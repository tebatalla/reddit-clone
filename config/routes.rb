Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:new]
  end
  resources :posts, except: [:index, :destroy, :new] do
    resources :comments, only: [:new]
    member do
      post 'upvote'
      post 'downvote'
    end
  end
  resources :comments, only: [:create, :show] do
    member do
      post 'upvote'
      post 'downvote'
    end
  end
end
