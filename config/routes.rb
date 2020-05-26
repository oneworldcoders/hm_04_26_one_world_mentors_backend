Rails.application.routes.draw do
  resources :courses

  root "user#index"
  get "user/index"
  post "signup", to: "user#signup"
  get "user/:id", to: "user#show"
  patch "user/profile/:id", to: "user#update_user"
  patch "user/profile_picture/:id", to: "user#update_profile_image"
  get "mentors", to: "mentors#mentors"
  get "mentees", to: "mentees#index"
  post "login" => "auth#create"
  get "profile", to: "profile#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
