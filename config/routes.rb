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
  
  # ユーザー側ルーティング
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
