class Mentee < ApplicationRecord
  belongs_to :user 
  belongs_to :mentor, optional: true
  belongs_to :course, optional: true
  has_many :mentee_subtracks
  has_many :subtracks, through: :mentee_subtracks

  after_update do
    course = self.course
    create_progress(self, course) if course
  end

  private
  def create_progress(mentee, course)
    delete_previous_subtracks(mentee)
    
    course.subtracks.each do |subtrack|
      mentee.mentee_subtracks.create(subtrack: subtrack)
    end
  end

  def delete_previous_subtracks(mentee)
    mentee.mentee_subtracks.each { |mentee_subtrack| mentee_subtrack.destroy }
  end
end
