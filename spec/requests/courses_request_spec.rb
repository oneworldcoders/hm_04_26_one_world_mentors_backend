require 'rails_helper'

RSpec.describe "Courses", type: :request do

    describe "GET /courses" do
        it "returns empty list of courses" do
          get "/courses"
          courses = JSON.parse(response.body)
          expected = {"courses"=>[]}
          expect(response).to have_http_status(:success)
          expect(courses).to eq(expected)
        end

        it "returns a single course in a list" do
          course = Course.create(courseCode: "CS001", name: "Computer Science", description: "Fundamentals of bits")
          get "/courses"
          courses = JSON.parse(response.body)
          expect(courses["courses"].first["courseCode"]).to eq("CS001")
          expect(courses["courses"].first["name"]).to eq("Computer Science")
          expect(courses["courses"].first["description"]).to eq("Fundamentals of bits")
        end
    end
end