require 'rails_helper'

RSpec.describe "User", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/user/index"
      expect(response).to have_http_status(:success)
    end
  end

  context 'user_signup' do
    it 'creates a new user' do
      headers = { 'ACCEPT' => 'application/json' }
      post '/signup', params: { user: { first_name: 'Julius', last_name: 'Ngwu', email:'julius@1', password:'julius@@1', user_type:'mentee' } }, headers: headers
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:created)
    end
    it 'fails to creates a user' do
      headers = { 'ACCEPT' => 'application/json' }
      post '/signup', params: { user: { firkst_name: 'Julius', last_name: 'Ngwu', email:'julius@1', password:'julius@@1', user_type:'mentee' } }, headers: headers
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.body).to include('error')
    end
  end

end
