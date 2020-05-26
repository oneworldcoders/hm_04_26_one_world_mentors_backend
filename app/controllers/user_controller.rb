class UserController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :signup]

  def index
    render json: { message: "Welcome to One world Mentors" }, status: 200
  end

  def signup
    @new_user = User.new(user_params)

    if @new_user.valid?
      @new_user.save

      render json: @new_user, status: 201
    else
      render json: @new_user.errors.details, status: 500
    end
  end

  def update_user
    current_user = User.find(params[:id])
    payload = JSON.parse(request.body.read)
    current_user.first_name = payload["first_name"] unless payload['first_name']&.empty?
    current_user.email = payload["email"] unless payload['email']&.empty?
    current_user.last_name = payload["last_name"] unless payload['last_name']&.empty?
    current_user.user_type = payload["user_type"] unless payload['user_type']&.empty?

    if current_user.valid?
      current_user.save
      render json: current_user, status: :ok
    else
      render json: current_user.errors.details, status: :bad_request
    end
  end

  def show
    user = User.find_by(:id => params[:id])
    if user.present?
      render json: { data: user}, status: :ok
    else
      render json: { message: "User with Id: " + params[:id] + " is not found" }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :user_type)
  end
end
