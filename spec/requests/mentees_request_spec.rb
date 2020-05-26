require "rails_helper"

RSpec.describe "Mentees", type: :request do
  include Helpers
  let(:headers) { login }
  describe "GET /index" do
    context "fetch mentees" do
      it "returns a list of mentee" do
        User.create(first_name: "Julius", last_name: "Ngwu", email: "julius@gmail.com", password: "julius@1", user_type: "mentee")
        get "/mentees", headers: headers
        mentees = JSON.parse(response.body)
        expect(response).to have_http_status(:success)

        expect(mentees["mentees"].first["first_name"]).to eq("Julius")
        expect(mentees["mentees"].first["last_name"]).to eq("Ngwu")
        expect(mentees["mentees"].first["email"]).to eq("julius@gmail.com")
        expect(mentees["mentees"].first["user_type"]).to eq("mentee")
      end
    end
    context "fail to fetch mentees" do
      it "returns empty list of mentee" do
        get "/mentees", headers: headers
        mentees = JSON.parse(response.body)
        expect(mentees["message"]).to eq("No mentee recorded")
      end
    end
  end
end
