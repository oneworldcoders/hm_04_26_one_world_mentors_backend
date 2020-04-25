require 'rails_helper'

RSpec.describe "Users", type: :request do

    describe "GET /mentors" do
        it "returns empty list of mentors" do
          get "/mentors"
          expect(response).to have_http_status(:success)
        end

        it "returns a single mentor in a list" do
          user = User.create(first_name: "mike", last_name: "tyson", email:"rm@mail.com", password: "yes", user_type:"mentor")
          get "/mentors"
          expect(response.body).to include("mike")
          mentors = JSON.parse(response.body)
          expect(mentors["mentors"].first["first_name"]).to eq("mike")
          expect(mentors["mentors"].first["last_name"]).to eq("tyson")
          expect(mentors["mentors"].first["email"]).to eq("rm@mail.com")
          expect(mentors["mentors"].first["password"]).to eq("yes")
          expect(mentors["mentors"].first["user_type"]).to eq("mentor")
        end
    end
end