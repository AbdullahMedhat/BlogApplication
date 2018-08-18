Rails.application.routes.draw do
  root to: 'blogs#index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }

  put 'users/update', to: 'users#update'

  get 'blogs/myblogs'
  resources :blogs
  get 'blogs/:id/verify', to: 'blogs#verify', as: :blog_verify
  post 'blogs/:id/verify_user', to: 'blogs#verify_thats_me', as: :verify_user
end
