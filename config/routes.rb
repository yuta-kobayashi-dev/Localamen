Rails.application.routes.draw do
  namespace :public do
    get 'users/show'
    get 'users/index'
    get 'users/edit'
  end
  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    resources :users, only: [:index, :show, :update, :destroy]
    resources :stores, only: [:index, :show, :create, :update, :destroy]
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'customer_unsubscribe'
    patch 'users/withdraw' => 'customers#withdraw', as: 'customer_withdraw'
    resources :places, only: [:index, :show]
  end
  
  
end
