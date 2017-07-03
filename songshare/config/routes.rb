Rails.application.routes.draw do

  post 'recommendations' => 'recommendations#create'
  get 'recommendations' => 'recommendations#list'
  get 'recommendations/like' => 'recommendations#like'
  get 'recommendations/like' => 'recommendations#unlike'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :friends, only: [:index, :new, :create, :destroy]
  post 'friends/:id/confirm', to: 'friends#confirm', as: :confirm_friend

  resources :songs, only: :show do
    collection do
      get 'search'
    end
  end

  root to: 'home#index'
end
