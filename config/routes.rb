Rails.application.routes.draw do
  root 'user#index'
  get 'user/index'
  post 'signup', to: 'user#signup'
  patch 'user/profile/:id', to: 'user#update_user'
  get 'mentors', to: 'mentors#mentors'
end
