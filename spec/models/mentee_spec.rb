require 'rails_helper'

RSpec.describe Mentee, type: :model do
  it { is_expected.to belong_to(:user) }
  it { should belong_to(:course).optional(true) }
  it { is_expected.to have_many(:mentee_subtracks) }
  it { is_expected.to have_many(:subtracks) }
end
