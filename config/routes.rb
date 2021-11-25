Rails.application.routes.draw do

  namespace :admin do
    get 'admins/edit'
  end
  namespace :user do
    get 'relationships/followings'
    get 'relationships/followers'
  end
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
    resources :admins, only: [:edit, :update]
    resources :posts, only: [:index, :show]
    resources :genres, only: [:create, :index, :edit, :update, :destroy]
  end

  # ユーザー側ルーティング
  scope module: :user do
    root to: "homes#top"
    get 'about' => "homes#about", as: 'about'
    resources :rooms, only: [:show, :create]
    resources :messages, only: [:create]
    resources :hashtags, only: [:show]
    
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    
    get 'users/unsubscribe/:id' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/:id/withdraw/' => 'users#withdraw', as: 'withdraw'
    put 'withdraw/:id' => 'users#withdraw'
    get "search" => "searches#search"
    get "pv_ranking" => 'posts#pv_ranking'
    resources :notifications, only: [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
