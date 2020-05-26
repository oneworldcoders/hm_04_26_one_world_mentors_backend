require "rails_helper"

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "authenticate" do
    let(:user) { FactoryBot.create(:user) }

    it "should return  valid user if credentials are valid" do
      auth_user = User.authenticate(user["email"], user["password"])
      expect(auth_user["email"]).to eq(user["email"])
    end
    it "should return nil if credentials are not valid" do
      auth_user = User.authenticate("joy123", "williams")
      expect(auth_user).to eq(nil)
    end
  end
  context "with find_or_create" do
    user_details = { "sub" => "auth0||123", "email" => "k@k.com" }
    it "should create a user if doesn't exist" do
      expect(User.count).to eql(0)
      User.find_or_create(user_details)
      expect(User.count).to eql(1)
    end
    context "when user exists" do
      before do
        User.find_or_create(user_details)
      end
      it "dosen't create a user if exist" do
        expect(User.count).to eql(1)
        User.find_or_create(user_details)
        expect(User.count).to eql(1)
      end
    end
  end
end
