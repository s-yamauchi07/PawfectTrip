Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "plans#index"
  resources :users, only: [:show]
  get "users/:id/unsubscribe", to: "users#unsubscribe", as: "unsubscribe"
  patch "users/:id/withdraw", to: "users#withdraw", as: "withdraw"
  
  resources :hotels, only: [:show,:create, :destroy] do
    collection do
      get 'search'
    end
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'pets', to: 'users/registrations#new_pet'
    post 'pets', to: 'users/registrations#create_pet'
    patch 'pets/:id', to: 'users/registrations#update_pet',as: :update_pet
  end
  # 退会用ページを表示するためのルーティング

  resources :plans do
    resources :itineraries, only:[:new, :create]
    resource :likes, only: [:create, :destroy] 
    resources :comments, only: [:index, :create, :edit, :update, :destroy]
    collection do
      get 'search'
    end
  end

  resources :guides, only: [:index]
  
end
