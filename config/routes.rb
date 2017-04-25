Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :subs do
    resources :posts, only: [:index, :new]
  end
  resource :session
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'subs#index'
end
