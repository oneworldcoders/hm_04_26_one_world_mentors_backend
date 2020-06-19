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
    context "add course" do
      it "should add a course to a mentee" do
        user = FactoryBot.create(:user)
        user1 = FactoryBot.create(:user)
        course = FactoryBot.create(:course)
        new_mentee = Mentee.create(id:1, user:user)
        Mentor.create(user:user1, available:true)
        patch "/mentees/#{new_mentee.id}", params: { course_id: course.id }, headers: headers
        mentees = JSON.parse(response.body)
        expect(mentees["course_id"]).to eq(course.id)
      end
    end

    context "fetches mentee" do
      let(:user) { FactoryBot.create(:user) }
      let(:user1) { FactoryBot.create(:user) }
      let(:course) { course = FactoryBot.create(:course) }

      before do
        @mentor = Mentor.create(id:1, user:user)
        @new_mentee = Mentee.create(id:1, user:user1, course:course, mentor:@mentor)
        get "/mentees/#{@new_mentee.id}", headers: headers
        @mentees = JSON.parse(response.body)
      end
      
      it "should retuen a mentee" do
        expect(@mentees['mentee']['id']).to eq(@new_mentee.user.id)
      end

      it "should return a meentor record" do
        expect(@mentees['mentor']['id']).to eq(@new_mentee.mentor.user.id)
      end

      it "should return a course record" do
        expect(@mentees['course']['id']).to eq(@new_mentee.course.id)
      end

      it "should return a bad request" do
        get "/mentees/test", headers: headers
        expect(response).to have_http_status 400
        expect(response.body).to eq ({ message: "Mentee Record Not Found" }.to_json)
      end
    end
  end
end
