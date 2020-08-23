require 'rails_helper'

RSpec.describe MenteeSubtrack, type: :model do
  it { is_expected.to belong_to(:mentee) }
  it { is_expected.to belong_to(:subtrack) }
  it { is_expected.to validate_presence_of(:mentee_id) }
  it { is_expected.to validate_presence_of(:subtrack_id) }
end
