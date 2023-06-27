Rails.application.routes.draw do
  # ユーザー関連
  get 'users/show', to:'users/show'
  get 'users/mypage', to:'users/mypage'
  get 'users/show/edit', to: 'users#edit'
  resources :users, only: [:show, :edit, :update]
  devise_for :users
  get 'users/sogn_out' => 'devise/sessions#destroy'
  post 'users/:id/edit' => 'users#show'

  # ホーム設定
  get 'home/index'
  root to: 'home#index'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
