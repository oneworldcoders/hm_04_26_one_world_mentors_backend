require 'rails_helper'

RSpec.describe "Passwords", type: :request do

  context '#forgot' do
    context 'email not present' do
      before { post '/password/forgot' }
        
      it 'returns an error when email not present' do
        expected = JSON.parse(response.body)
        expect(expected['error']).to be_present
      end
  
      it 'returns a not found request' do
        post '/password/forgot', params: { email: 'test@email' }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'successful' do
      it 'returns an ok response' do
        user = FactoryBot.create(:user)
        post '/password/forgot', params: { email: user.email }
        expect(response).to have_http_status(:ok)
      end

      it 'it generates a reset token' do
        user = FactoryBot.create(:user)
        expect(user.reset_password_token).to be_nil

        post '/password/forgot', params: { email: user.email }
        user = User.find_by_email(user.email)
        expect(user.reset_password_token).to be_present
      end
    end
  end

  context '#reset' do
    it 'returns error when no token' do
      post '/password/reset'
      expected = JSON.parse(response.body)
      expect(expected['error']).to be_present
    end

    it 'returns invalid link' do
      post '/password/reset', params: { token: 'token' }
      expected = JSON.parse(response.body)
      expect(expected['error']).to be_present
      expect(expected['error']).to eq(["Link not valid or expired. Try generating a new link."])
    end

    it 'resets the password' do
      user = FactoryBot.create(:user)
      old_pasword_hash = user.password
      new_password = 'password'
      post '/password/forgot', params: { email: user.email }

      user = User.find_by_email(user.email)
      post '/password/reset', params: { token: user.reset_password_token, password: new_password }

      user = User.find_by_email(user.email)
      expect(user.password).not_to eq(old_pasword_hash)
    end
  end
end
