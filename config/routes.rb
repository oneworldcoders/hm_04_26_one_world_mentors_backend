Rails.application.routes.draw do
  resources :courses

  root "user#index"
  get "user/index"
  post "signup", to: "user#signup"
  patch "user/profile/:id", to: "user#update_user"
  get "mentors", to: "mentors#mentors"
  get "mentees", to: "mentees#index"
  post "login" => "auth#create"
  get "profile", to: "profile#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
