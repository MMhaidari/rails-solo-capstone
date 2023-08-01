Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/new'
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: 'users#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'home#index', as: :unauthenticated_root
    end
  end
end