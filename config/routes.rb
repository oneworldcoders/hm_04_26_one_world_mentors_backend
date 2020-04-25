Rails.application.routes.draw do
  root 'user#index'
  get 'user/index'
  post 'signup', to: 'user#signup'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'mentors', to: 'mentors#mentors'
end
