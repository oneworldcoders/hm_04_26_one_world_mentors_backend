module Helpers
  def login
    user = FactoryBot.create(:user)
    post "/login", params: { "email" => user.email, "password" => User::TEST_PASSWORD }
    user_info = JSON.parse(response.body)
   { "Authorization" => "Bearer " + user_info["token"] }
  end
end
