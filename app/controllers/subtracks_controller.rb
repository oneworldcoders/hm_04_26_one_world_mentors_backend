class SubtracksController < ApplicationController
  before_action :set_subtrack, only: [:show, :update, :destroy]

  def index
    @subtracks = Subtrack.all

    render json: { subtracks: @subtracks }
  end

  def show
    render json: { subtrack: @subtrack }
  end

  def create
    @subtrack = Subtrack.new(subtrack_params)

    if @subtrack.save
      render json: {subtrack: @subtrack}, status: :created
    else
      render json: {errors: @subtrack.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @subtrack.update(subtrack_params)
      render json: {subtrack: @subtrack}
    else
      render json: {errors: @subtrack.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @subtrack.destroy
  end

  private
  def set_subtrack
    @subtrack = Subtrack.find(params[:id])
  end

  def subtrack_params
    params.permit(:name, :description, :course_id)
  end
end
