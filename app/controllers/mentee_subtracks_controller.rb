class MenteeSubtracksController < ApplicationController
  before_action :set_mentee_subtrack, only: [:show, :update]
  before_action :set_mentee_subtracks, only: [:index, :update]

  def index
    render json: { subtracks: @mentee_subtracks, progress: progress}
  end

  def update
    if @mentee_subtrack.update(mentee_subtrack_params)
      render json: { subtrack: @mentee_subtrack, progress: progress}
    else
      render json: @mentee_subtrack.errors, status: :unprocessable_entity
    end
  end


  private
  def set_mentee_subtrack
    @mentee_subtrack = MenteeSubtrack.find(params[:id])
  end

  def set_mentee_subtracks
    mentee = Mentee.find_by(user_id: @current_user['id'])
    @mentee_subtracks = mentee.mentee_subtracks
  end

  def mentee_subtrack_params
    params.permit(:mentee_id, :subtrack_id, :completed)
  end

  def progress
    completed_count = @mentee_subtracks.where(completed: true).count
    all_count = @mentee_subtracks.count
    progress = completed_count.to_f/all_count
  end
end
