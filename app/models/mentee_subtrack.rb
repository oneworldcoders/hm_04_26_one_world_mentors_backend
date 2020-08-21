class MenteeSubtrack < ApplicationRecord
  validates :mentee_id, presence: true
  validates :subtrack_id, presence: true

  belongs_to :mentee
  belongs_to :subtrack
end
