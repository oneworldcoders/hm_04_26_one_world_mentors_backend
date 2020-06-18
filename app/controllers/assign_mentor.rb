class AssignMentor
  def self.assign(mentee, course_id)
    available_mentors = Mentor.where(available: true)
    assigned_mentor = available_mentors.find do |mentor|
      mentor.courses.where(id: course_id)
    end

    mentee.update!(mentor_id:assigned_mentor.id)
  end
end
