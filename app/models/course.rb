class Course < ApplicationRecord
  validates :courseCode, presence: true
  validates :description, presence: true
  validates :name, presence: true
end
