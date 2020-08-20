class Rating < ApplicationRecord
    validates :mentor_id, presence: true
    validates :course_id, presence: true
    validates :mentee_id, presence: true
    validates :mark, presence: true

    belongs_to :mentor
    belongs_to :course
    belongs_to :mentee
end
