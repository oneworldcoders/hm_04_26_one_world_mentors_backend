require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'is valid when all attributes are provided' do
    new_user = User.new(first_name: 'Julius', last_name: 'Ngwu', email:'julius@gmail.com',password:'julius@1', user_type:'mentee')
    expect(new_user).to be_valid
  end
end
