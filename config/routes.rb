Rails.application.routes.draw do
  
  namespace :user do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  
  namespace :admin do
    get 'users/index'
    get 'users/show'
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
    resources :posts, only: [:index, :show]
    resources :genres, only: [:create, :index, :edit, :update, :destroy]
  end

  # ユーザー側ルーティング
  scope module: :user do
    root to: "homes#top"
    get 'about' => "homes#about", as: 'about'
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]
    get 'users/unsubscribe/:id' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/:id/withdraw/' => 'users#withdraw', as: 'withdraw'
    put 'withdraw/:id' => 'users#withdraw'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
