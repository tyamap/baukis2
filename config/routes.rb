Rails.application.routes.draw do
  config = Rails.application.config.baukis2

  # ホスト名による制約を追加
  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ]
    end
  end
  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
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
  end

  namespace :customer do
    root "top#index"
  end
end
