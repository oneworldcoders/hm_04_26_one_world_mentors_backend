require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { is_expected.to belong_to(:mentee) }
  it { is_expected.to belong_to(:mentor) }
  it { is_expected.to belong_to(:course) }
end
