class MenteesController < ApplicationController

  def index
    mentees = User.where(user_type: "mentee")

    if mentees.empty?
      render json: { message: "No mentee recorded" }, status: :not_found
    else
      render json: { mentees: mentees }, status: :ok
    end
  end

  def add_course
    course_id = params[:course_id]
    current_mentee = Assign.course(params[:id], course_id)
    Assign.mentor(current_mentee, course_id)
    render json: current_mentee, status: :ok
  end
end
