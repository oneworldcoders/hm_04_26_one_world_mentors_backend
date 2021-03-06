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
    current_mentee = Assign.course(@current_user['id'], course_id)
    Assign.mentor(current_mentee, course_id)
    render json: current_mentee, status: :ok
  end

  def fetch_mentee_record
    current_mentee = Mentee.find_by(:user_id => params[:id])
    if current_mentee.present?
      render json: { message: "Mentee Record fetched succesfully", 
                     mentee: current_mentee, 
                     mentor: current_mentee.mentor,
                     course: current_mentee.course }, status: 200
    else
      render json: { message: "Mentee Record Not Found" } , status: 400
    end
  end
end
