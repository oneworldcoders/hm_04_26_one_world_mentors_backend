require 'rails_helper'

RSpec.describe "/subtracks", type: :request do
  include Helpers
  let(:valid_headers) {login}
  let(:valid_attributes) { { name: 'name', description: 'description', course_id: @course.id } }
  let(:new_attributes) { { name: 'name 2', description: 'description 2' } }
  let(:invalid_attributes) { { course_id: 100 } }
  let(:subtrack) { FactoryBot.create(:subtrack) }

  describe "GET /index" do
    before do
      @expected_index = [JSON.parse(subtrack.to_json)]
      get subtracks_url, headers: valid_headers
      @subtrack_response = JSON.parse(response.body)
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "renders a JSON response with the new subtrack" do
      expect(response).to have_http_status(:ok)
      expect(@subtrack_response).to include('subtracks')
    end

    it "returns a list of all subtracks" do
      expect(response).to have_http_status(:ok)
      expect(@subtrack_response['subtracks']).to eq(@expected_index)
    end
  end

  describe "GET /show" do
    before do
      get subtrack_url(subtrack), headers: valid_headers
      @subtrack_response = JSON.parse(response.body)
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "response includes a subtrack" do
      expect(response.body).to include('subtrack')
    end

    it "returns a subtrack" do
      expect(@subtrack_response['subtrack']['id']).to eq(subtrack.id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      before do
        @course = FactoryBot.create(:course, id: 1)
        post subtracks_url, params: valid_attributes, headers: valid_headers
        @subtrack_response = JSON.parse(response.body)
      end

      it "creates a new Subtrack for course" do
        expect(Subtrack.all.count).to eq(1)
      end

      it "renders a JSON response with the new subtrack" do
        expect(response).to have_http_status(:created)
        expect(@subtrack_response).to include('subtrack')
      end

      it "returns the created subtrack" do
        expect(response).to have_http_status(:created)
        expect(@subtrack_response['subtrack']['name']).to eq(valid_attributes[:name])
        expect(@subtrack_response['subtrack']['description']).to eq(valid_attributes[:description])
        expect(@subtrack_response['subtrack']['course_id']).to eq(valid_attributes[:course_id])
      end
    end

    context "with invalid parameters" do
      before do
        @course = FactoryBot.create(:course, id: 1)
        post subtracks_url, params: invalid_attributes, headers: valid_headers
        @subtrack_response = JSON.parse(response.body)
      end

      it "does not create a new Subtrack" do
        expect(Subtrack.all.count).to eq(0)
      end

      it "renders a JSON response with errors for the new subtrack" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(@subtrack_response).to include('errors')
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      before do
        patch subtrack_url(subtrack), params: new_attributes , headers: valid_headers
        @subtrack_response = JSON.parse(response.body)
      end

      it "updates the requested subtrack" do
        subtrack.reload

        expect(subtrack.name).to eq(new_attributes[:name])
        expect(subtrack.description).to eq(new_attributes[:description])
      end

      it "renders a JSON response with the subtrack" do
        expect(response).to have_http_status(:ok)
        expect(@subtrack_response).to include('subtrack')
      end

      it "returns the updated subtrack" do
        expect(@subtrack_response['subtrack']['name']).to eq(new_attributes[:name])
        expect(@subtrack_response['subtrack']['description']).to eq(new_attributes[:description])
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the subtrack" do
        patch subtrack_url(subtrack), params: invalid_attributes, headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('errors')
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested subtrack" do
      delete subtrack_url(subtrack), headers: valid_headers
      expect(Subtrack.all.count).to eq(0)
    end
  end
end
