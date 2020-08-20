require "rails_helper"

RSpec.describe SubtracksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/subtracks").to route_to("subtracks#index")
    end

    it "routes to #show" do
      expect(get: "/subtracks/1").to route_to("subtracks#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/subtracks").to route_to("subtracks#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/subtracks/1").to route_to("subtracks#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/subtracks/1").to route_to("subtracks#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/subtracks/1").to route_to("subtracks#destroy", id: "1")
    end
  end
end
