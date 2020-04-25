require 'rails_helper'

RSpec.describe "Users", type: :request do

    describe "GET /mentors" do
        it "returns empty list of mentors" do
          get "/mentors"
          expect(response).to have_http_status(:success)
        end

        it "returns a single mentor in a list" do
          user = User.new(first_name: "mike", last_name: "", email:"", password: "", user_type:"mentor")
          user.save
          get "/mentors"
          expect(response.body).to include("mike")
        end
    end
end