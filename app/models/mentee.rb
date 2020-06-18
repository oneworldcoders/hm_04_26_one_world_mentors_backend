class Mentee < ApplicationRecord
  belongs_to :user 
  belongs_to :mentor, optional: true
  belongs_to :course, optional: true
end
