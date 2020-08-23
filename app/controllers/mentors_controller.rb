class MentorsController < ApplicationController
  def mentors
    mentors = User.where(user_type: "mentor")
    render json: { mentors: mentors }, status: 200
  end

  def average_rating
    ratings = MentorCourse.where(mentor_id: params[:mentorId])
    result = ratings.map do |rate|
      {
        rating: rate.average_rate,
        course: rate.course.name,
        mentor: rate.mentor.user.first_name,
      }
    end

    render json: { data: result }, status: 200
  end
end
