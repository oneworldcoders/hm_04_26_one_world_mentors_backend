class Course < ApplicationRecord
  validates :courseCode, presence: true
  validates :description, presence: true
  validates :name, presence: true

  has_many :users
  has_many :mentor_courses
  has_many :mentors, through: :mentor_courses
  has_many :mentees
  has_many :subtracks
end
