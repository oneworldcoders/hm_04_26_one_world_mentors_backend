require 'rails_helper'

describe 'User', type: :request do

  headers = nil
  user = nil
  password="password908@"
  before do
    user = FactoryBot.create(:user, password:password)

    post "/login", params: {email:user["email"],password:password}
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