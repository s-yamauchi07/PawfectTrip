Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root "plans#index"
  resources :hotels, only: [:show,:create, :destroy] do
    collection do
      get 'search'
    end
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'pets', to: 'users/registrations#new_pet'
    post 'pets', to: 'users/registrations#create_pet'
  end

  resources :plans do
    resources :itineraries, only:[:new, :create]
    resources :likes, only: [:create, :destroy] 
    collection do
      get 'search'
    end
  end
end
