class Subtrack < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :course_id, presence: true

  belongs_to :course
end
