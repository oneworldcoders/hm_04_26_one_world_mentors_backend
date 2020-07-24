require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  user  =nil
  before do
    user= User.create(first_name: 'Julius', last_name: 'Ngwu', email:'julius@gmail.com',password:Helpers::TEST_PASSWORD, user_type:'mentee')
  end

  it 'is valid when all attributes are provided' do
    expect(user).to be_valid
  end
  it"The authenticate method should return  valid user if credentials are valid" do
    auth_user=User.authenticate(user["email"],Helpers::TEST_PASSWORD)
    expect(auth_user["email"]).to eq(user["email"])
  end
  it"The authenticate method should returna nil if credentials are not valid" do
    auth_user=User.authenticate("joy123","williams") 
    expect(auth_user).to eq(nil)
  end

  context 'after signup' do
    before do
      user = FactoryBot.create(:user, user_type: 'mentor')
      @mentor = Mentor.find_by(user_id: user.id)
    end

    it "creates a mentor on user signup" do
      expect(@mentor).to be_truthy
    end

    it "creates a mentor on user signup" do
      expect(@mentor.available).to eq true
    end

    it "creates a mentee on user signup" do
      user = FactoryBot.create(:user, user_type: 'mentee')
      expect(Mentee.find_by(user_id: user.id)).to be_truthy
    end
  end
end
