require 'rails_helper'

RSpec.describe Mentee, type: :model do
  it { is_expected.to belong_to(:user) }
  it { should belong_to(:course).optional(true) }

end
