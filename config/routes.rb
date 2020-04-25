Rails.application.routes.draw do
  root 'user#index'
  get 'user/index'
  post 'signup', to: 'user#signup'
  get 'mentors', to: 'mentors#mentors'
  get 'courses', to: 'courses#courses'
end
