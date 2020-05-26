class MenteesController < ApplicationController
  def index
    mentees = User.where(user_type: "mentee")

    if mentees.empty?
      render json: { message: "No mentee recorded" }, status: :not_found
    else
      render json: { mentees: mentees }, status: :ok
    end
  end
end
