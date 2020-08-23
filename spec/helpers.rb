module Helpers
  TEST_PASSWORD="mentorspassword1234"
  
  def login
    @login_user = FactoryBot.create(:user)
    post_login
  end

  def login_admin
    @login_user = FactoryBot.create(:admin)
    post_login
  end

  def mentee_login
    @login_user = FactoryBot.create(:user, user_type: 'mentee')
    post_login
  end

  def post_login
    post "/login", params: { "email" => @login_user.email, "password" => TEST_PASSWORD }
    user_info = JSON.parse(response.body)
   { "Authorization" => "Bearer " + user_info["token"], "id" => @login_user['id'] }
  end

end
