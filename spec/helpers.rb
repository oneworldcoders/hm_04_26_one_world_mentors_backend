module Helpers
  TEST_PASSWORD="mentorspassword1234"
  
  def login
    user = FactoryBot.create(:user)
    post "/login", params: { "email" => user.email, "password" => TEST_PASSWORD }
    user_info = JSON.parse(response.body)
   { "Authorization" => "Bearer " + user_info["token"], "id" => user['id'] }
  end
end
