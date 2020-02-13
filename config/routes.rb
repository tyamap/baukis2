Rails.application.routes.draw do
  namespace :staff do
    root "top#index"
    get "login" => "sessions#new", as: :login
    # post "session" => "sessions#create", as: :session
    # delete "session" => "sessions#destroy"
    resource :session, only: [ :create, :destroy ]

    # 単数リソース（自分自身に対する管理機能）の６つの基本アクションを一括で設定する resource メソッド
    # 自分でアカウントを登録・追加する機能を除外
    resource :account, except: [ :new, :create, :destroy ]
  end

  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
    # post "session" => "sessions#create", as: :session
    # delete "session" => "sessions#destroy"
    resource :session, only: [ :create, :destroy ]

    # get "staff_members" => "staff_members#index", as: :admin_staff_members
    # get "staff_members/:id" => "staff_members#show", as: :admin_staff_member
    # get "staff_members/new" => "staff_members#new", as: :new_admin_staff_member
    # get "staff_members/:id/edit" => "staff_members#edit", as: :edit_admin_staff_member
    # post "staff_members" => "staff_members#create"
    # patch "staff_members/:id" => "staff_members#update"
    # delete "staff_members/:id" => "staff_members#destroy"
    # 以上７つの基本アクションを一括で設定できるのが resources メソッド。
    resources :staff_members
  end

  namespace :customer do
    root "top#index"
  end
end
