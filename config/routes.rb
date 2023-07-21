Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'pets', to: 'users/registrations#new_pet'
    post 'pets', to: 'users/registrations#create_pet'
  end
  root "plans#index"
end
