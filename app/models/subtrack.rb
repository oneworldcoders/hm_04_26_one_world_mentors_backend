class Subtrack < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :course_id, presence: true

  belongs_to :course
  has_many :mentee_subtracks
  has_many :mentees, through: :mentee_subtracks
end
