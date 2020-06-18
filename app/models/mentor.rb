class Mentor < ApplicationRecord
  belongs_to :user

  has_many :mentor_courses
  has_many :courses, through: :mentor_courses
end
