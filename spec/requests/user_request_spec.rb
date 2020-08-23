require "rails_helper"

RSpec.describe "User", type: :request do
  include Helpers
  let(:headers) { login }
  let(:admin_headers){login_admin}

  describe "GET /index" do
    it "returns welcome message" do
      get "/"
      expect(response.body["message"]).to include("message")
    end
  end

  context "user_signup" do
    let(:user) { FactoryBot.build(:user) }

    it "creates a new user" do
      headers = { "ACCEPT" => "application/json" }
      post "/signup", params: { user: { first_name: "Julius", last_name: "Ngwu", email: "julius@1", password: "julius@@1", user_type: "mentee" } }, headers: headers
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)
    end
    it "encrypts passwords on sign up" do
      headers = { "ACCEPT" => "application/json" }
      password = "julius@@34"
      post "/signup", params: { user: { first_name: "Julius", last_name: "Ngwu", email: "julius@1", password: password, user_type: "mentee" } }, headers: headers
      expect(User.first.password).to_not eq(password)
    end
    it "fails to creates a user" do
      headers = { "ACCEPT" => "application/json" }
      post "/signup", params: { user: { firkst_name: "Julius", last_name: "Ngwu", email: "julius@1", password: "julius@@1", user_type: "mentee" } }, headers: headers
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body).to include("error")
    end

    it "fails to signup if user already exist" do
      old_user = FactoryBot.create(:user)
      user.email = old_user.email
      user.should_not be_valid
    end
  end

  context "update_user" do
    before(:each) do
      @user = FactoryBot.create(:user)
    end

    it "update a user profile" do
      patch "/user/profile/#{@user.id}", params: { first_name: "Ebuka", last_name: "Ngwu", email: "ebuka@1", user_type: "mentor" }.to_json, headers: headers

      updated_user = JSON.parse(response.body)
      expect(updated_user["first_name"]).to eq("Ebuka")
      expect(updated_user["last_name"]).to eq("Ngwu")
      expect(updated_user["email"]).to eq("ebuka@1")
      expect(updated_user["user_type"]).to eq("mentor")
    end

    it "should retain the old user profile when empty field is passed" do
      patch "/user/profile/#{@user.id}", params: { first_name: "", last_name: "", email: "", user_type: "mentor" }.to_json, headers: headers

      updated_user = JSON.parse(response.body)
      expect(updated_user["first_name"]).to eq(@user.first_name)
      expect(updated_user["last_name"]).to eq(@user.last_name)
      expect(updated_user["email"]).to eq(@user.email)
      expect(updated_user["user_type"]).to eq("mentor")
    end

    it "should fail to update profile when the field is incorrect" do
      patch "/user/profile/#{@user.id}", params: { first_namesss: "Ebuka" }.to_json, headers: headers
      expect(response).to have_http_status(400)
    end
  end
  context "get single user" do
    it "get a specific user details" do
      user = FactoryBot.create(:user)
      get "/user/#{user.id}", headers: headers

      data = JSON.parse(response.body)
      expect(data["data"]["first_name"]).to eq(user.first_name)
      expect(data["data"]["email"]).to eq(user.email)
      expect(data["data"]["user_type"]).to eq(user.user_type)
    end
    it "should fail to return user" do
      get "/user/99999", headers: headers
      data = JSON.parse(response.body)

      expect(data["message"]).to eq("User with Id: 99999 is not found")
    end
  end

  context "update_profile_picture" do
    before(:each) do
      stub_request(:any, /api.cloudinary.com/).to_return(body: { url: "http://res.cloudinary.com/opix/image/upload/v1590572920/test.png" }.to_json)
      @new_user = FactoryBot.create(:user)
    end

    let(:file) {
      Rack::Test::UploadedFile.new(Rails.root.join("spec",
                                                   "fixtures", "test.png"), "image/jpg")
    }
    it "adds an image_url value to the field in the database" do
      expect(@new_user.image_url).to be nil
      patch "/user/profile_picture/#{@new_user.id}", params: { image_url: file }, headers: headers
      user = User.find(@new_user.id)
      expect(user.image_url).to be_truthy
    end

    it "updates profile image and returns the stubbed url" do
      patch "/user/profile_picture/#{@new_user.id}", params: { image_url: file }, headers: headers

      expect(response.body).to eq({ url: "http://res.cloudinary.com/opix/image/upload/v1590572920/test.png" }.to_json)
    end
  end

  context "create_admin" do
    it "creates a new admin" do
      post "/create_admin", params: { user: { first_name: "Julius", last_name: "Ngwu", email: "julius@1", password: "julius@@1", user_type: "admin" } }, headers: admin_headers
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)
    end

    it "fails to create a user if the opreation is not initiated by an admin" do
      user = FactoryBot.create(:user)
      post "/create_admin", params: { user: { first_name: "Julius", last_name: "Ngwu", email: "julius@1", password: "julius@@1", user_type: "admin" } }, headers: headers
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unauthorized)
    end
    context "rate_mentor" do
      it "rate a mentor" do
        mentee = FactoryBot.create(:mentee)
        mentor = FactoryBot.create(:mentor)
        course = FactoryBot.create(:course)

        post "/rate", params: { mark: 5, mentee_id: mentee.id, course_id: course.id, mentor_id: mentor.id } , headers: headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
      end

      it "fails to rate a mentor mentor is not provided" do
        mentee = FactoryBot.create(:mentee)
        course = FactoryBot.create(:course)

        post "/rate", params: { mark: 5, mentee_id: mentee.id, course_id: course.id } , headers: headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("error")
      end
    end

    context "update_user_role" do
      it "update a user role" do
        user = FactoryBot.create(:user)
        patch "/admin/user_role/#{user.id}", params: { user_type: "admin" }, headers: admin_headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("User role updated succesfully")
        expect(response).to have_http_status(:ok)
      end
  
      it "fails to update a user role if the opreation is not initiated by an admin" do
        user = FactoryBot.create(:user)
        patch "/admin/user_role/#{user.id}", params: { user_type: "admin" }, headers: headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unauthorized)
      end

      it "fails if user does not exist" do
        patch "/admin/user_role/600", params: { user_type: "admin" }, headers: admin_headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("User does not exist")
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
