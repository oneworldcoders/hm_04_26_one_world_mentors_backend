Rails.application.routes.draw do
  resources :courses
  resources :subtracks
  resources :mentee_subtracks

  root "user#index"
  get "user/index"
  post "signup", to: "user#signup"
  get "user/:id", to: "user#show"
  patch "user/profile/:id", to: "user#update_user"
  patch "user/profile_picture/:id", to: "user#update_profile_image"
  get "mentors", to: "mentors#mentors"
  get "mentees", to: "mentees#index"
  patch "mentees/", to: "mentees#add_course"
  post "login" => "auth#create"
  get "profile", to: "profile#show"
  get "mentees/:id" => "mentees#fetch_mentee_record"

  post "password/forgot", to: "passwords#forgot"
  post "password/reset", to: "passwords#reset"
  post "create_admin", to: "user#create_admin"
  post "rate", to: "user#rate_mentor"
  patch "admin/user_role/:id", to: "user#update_user_role"

  get "ratings/:mentorId", to: "mentors#average_rating"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
