Rails.application.routes.draw do
  
  # デバイス管理者側
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # デバイスユーザー側
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }

  # 管理者側ルーティング
  namespace :admin do
    resources :users, only: [:index, :show]
    resources :posts, only: [:index, :show]
    resources :genres, only: [:create, :index, :edit, :update, :destroy]
  end

  # ユーザー側ルーティング
  scope module: :user do
    root to: "homes#top"
    get 'about' => "homes#about", as: 'about'
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :hashtags, only: [:show]
    resources :users, only: [:show, :edit, :update]
    get 'users/unsubscribe/:id' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/:id/withdraw/' => 'users#withdraw', as: 'withdraw'
    put 'withdraw/:id' => 'users#withdraw'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
