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
    current_mentee = Mentee.find(params[:id])
    current_mentee.update!(course_id: params[:course_id])
    render json: current_mentee, status: :ok
  end


end
