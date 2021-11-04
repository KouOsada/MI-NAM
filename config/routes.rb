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
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
