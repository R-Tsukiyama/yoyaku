Rails.application.routes.draw do
  
  devise_for :users
  # ホーム設定
  get 'home/index'
  root to: 'home#index'
  # ユーザー関連
  get 'users/mypage', to: 'users#mypage'
  get 'users/show', to: 'users#show'
  get 'users/show/edit', to: 'users#edit'
  resources :users, only: [:show, :edit, :update]
  get 'users/sign_out' => 'devise/sessions#destroy'
  post 'users/:id/edit' => 'users#show'

  #施設関連
  
  get 'rooms/search', to: 'rooms#search', as: 'search_rooms'
  resources :rooms
  
  #予約関連
  resources :reservations do
    collection do
      post 'confirm'
    end
  end
  post 'reservations/:id', to: 'reservations#index'
  get 'reservations/index', to: 'reservations#index'

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
