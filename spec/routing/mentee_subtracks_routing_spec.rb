require "rails_helper"

RSpec.describe MenteeSubtracksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/mentee_subtracks").to route_to("mentee_subtracks#index")
    end

    it "routes to #show" do
      expect(get: "/mentee_subtracks/1").to route_to("mentee_subtracks#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/mentee_subtracks").to route_to("mentee_subtracks#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/mentee_subtracks/1").to route_to("mentee_subtracks#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/mentee_subtracks/1").to route_to("mentee_subtracks#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/mentee_subtracks/1").to route_to("mentee_subtracks#destroy", id: "1")
    end
  end
end
