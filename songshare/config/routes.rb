Rails.application.routes.draw do
  resources :recommendations, only: [:create, :index]

  get 'top_tracks' => 'top_tracks#show'
  get '/sent' => 'recommendations#sent'
  get 'recommendations/received' => 'recommendations#received'
  get '/all' => 'recommendations#all'

  post 'recommendations/like' => 'recommendations#like'
  post 'recommendations/dislike' => 'recommendations#dislike'
  post 'recommendations/comment' => 'recommendations#comment'

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
