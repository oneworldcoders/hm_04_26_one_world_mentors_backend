class Assign
  def self.mentor(mentee, course_id)
    available_mentors = Mentor.where(available: true)
    assigned_mentor = available_mentors.find do |mentor|
      mentor.courses.where(id: course_id)
    end

    mentee.update!(mentor_id: assigned_mentor.id)
  end

  def self.course(mentee_id, course_id)
    current_mentee = Mentee.find(mentee_id)
    current_mentee.update!(course_id: course_id)
    current_mentee
  end
end
