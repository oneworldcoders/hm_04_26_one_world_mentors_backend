require 'rails_helper'

describe 'User', type: :request do
  user=nil
  headers = nil
  before do
    user = FactoryBot.create(:user)
    user_without_id = JSON.parse(user.to_json).except("id")
    User.create(user_without_id)

    post "/login", params: {email:user["email"],password:User::TEST_PASSWORD}
    user_info = JSON.parse(response.body)
    headers = { "Authorization" => "Bearer " + user_info["token"] }
  end

  it 'returns my profile' do
    get '/profile', params: JSON.parse(user.to_json).except("id"), headers: headers

    actual = JSON.parse(response.body)
    expect(response).to have_http_status(:success)
    expect(actual['profile']['first_name']).to eq(user['first_name'])
    expect(actual['profile']['last_name']).to eq(user['last_name'])
    expect(actual['profile']['email']).to eq(user['email'])
  end
end