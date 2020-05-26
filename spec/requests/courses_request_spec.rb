require 'rails_helper'

RSpec.describe "Courses", type: :request do
  headers = nil
  before do
    User.create(first_name: "Julius", last_name: "Ngwu", email: "julius@gmail.com", password: "julius@1", user_type: "mentee")
    post "/login", params: { "email" => "julius@gmail.com", "password" => "julius@1" }
    user_info = JSON.parse(response.body)
    headers = { "Authorization" => "Bearer " + user_info["token"] }
  end

    describe "GET /courses" do
        it "returns empty list of courses" do
          get "/courses", headers: headers
          courses = JSON.parse(response.body)
          expected = {"courses"=>[]}
          expect(response).to have_http_status(:success)
          expect(courses).to eq(expected)
        end

        it "returns a single course in a list" do
          Course.create(courseCode: "CS001", name: "Computer Science", description: "Fundamentals of bits")
          get "/courses", headers: headers
          courses = JSON.parse(response.body)
          expect(courses["courses"].first["courseCode"]).to eq("CS001")
          expect(courses["courses"].first["name"]).to eq("Computer Science")
          expect(courses["courses"].first["description"]).to eq("Fundamentals of bits")
        end
    end

    context "create course" do
      it "creates a course" do
        headers = { "ACCEPT" => "application/json" }
        post "/courses", params: { course: { name: "Javascript", courseCode: "JS101", description: "JS for web development"  } }, headers: headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
        courses = JSON.parse(response.body)
        expect(courses["courseCode"]).to eq("JS101")
        expect(courses["name"]).to eq("Javascript")
        expect(courses["description"]).to eq("JS for web development")
      end
      it "fails to creates a course" do
        headers = { "ACCEPT" => "application/json" }
        post "/courses", params: { course: { namedd: "JJsss" } }, headers: headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("error")
      end
    end
end