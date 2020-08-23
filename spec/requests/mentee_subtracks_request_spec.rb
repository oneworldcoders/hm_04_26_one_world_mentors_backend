require 'rails_helper'

RSpec.describe "/mentee_subtracks", type: :request do
  include Helpers
  let(:valid_headers) {mentee_login}
  let(:new_attributes) { { completed: true } }
  let(:mentee_subtrack) { FactoryBot.create(:mentee_subtrack) }
  let(:course) { FactoryBot.create(:course) }
  let(:subtrack) { FactoryBot.create(:subtrack, course_id: course.id) }

  describe "GET /index" do
    before do
      get mentee_subtracks_url, headers: valid_headers
      @response = JSON.parse(response.body)
    end
    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "response includes subtracks" do
      expect(@response).to include('subtracks')
    end

    it "response includes progress" do
      expect(@response).to include('progress')
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      before do
        FactoryBot.create(:subtrack, course_id: course.id)
        FactoryBot.create(:subtrack, course_id: course.id)
        
        Assign.course(valid_headers['id'], course.id)
        patch mentee_subtrack_url(mentee_subtrack), params: new_attributes, headers: valid_headers
        @response = JSON.parse(response.body)
      end

      it "updates the requested mentee_subtrack" do
        mentee_subtrack.reload
        expect(mentee_subtrack.completed). to be_truthy
      end

      it "renders a JSON response with the mentee_subtrack" do
        expect(response).to have_http_status(:ok)
      end

      it "response includes subtracks" do
        expect(@response).to include('subtrack')
      end
  
      it "response includes progress" do
        expect(@response).to include('progress')
      end
    end
  end
end
