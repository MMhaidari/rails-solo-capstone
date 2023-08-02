Rails.application.routes.draw do
  get 'transaction_entries/index'
  get 'transaction_entries/new'
  get 'categories/index'
  get 'categories/new'
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: 'categories#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'home#index', as: :unauthenticated_root
    end
  end

    resources :categories, only: %i[new create index] do
    resources :transaction_entries, only: %i[new create index]
  end
end