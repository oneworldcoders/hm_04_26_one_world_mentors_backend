require 'rails_helper'

RSpec.describe "Courses", type: :request do
  include Helpers
  let(:headers){login}

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

  context "GET /courses/<id>" do
    let(:course) { FactoryBot.create(:course) }
    let(:course_id) { course.id }
    let(:course_code) { course.courseCode }
    let(:course_name) { course.name }
    let(:course_description) { course.description }
    
    it "returns a nil when no course" do
      get "/courses/FakeCourse", headers: headers
      courses = JSON.parse(response.body)
      expected = {"course"=>nil}
      expect(response).to have_http_status(:success)
      expect(courses).to eq(expected)
    end

    it "returns the course " do
      get "/courses/#{course_id}", headers: headers
      courses = JSON.parse(response.body)
      expect(courses["course"]["courseCode"]).to eq(course_code)
      expect(courses["course"]["name"]).to eq(course_name)
      expect(courses["course"]["description"]).to eq(course_description)
    end
  end
end
