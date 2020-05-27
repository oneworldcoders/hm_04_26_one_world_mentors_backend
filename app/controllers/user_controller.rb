class UserController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :signup]

  def index
    render json: { message: "Welcome to One world Mentors" }, status: 200
  end

  def signup
    Validation.sign_up_validate(user_params)
    @new_user = User.new(user_params)
    if @new_user.valid?
      @new_user.save
      render json: @new_user.as_json(except: [:password_digest, :created_at, :updated_at, :sub]), status: 201
    else
      render json: @new_user.errors.details, status: 500
    end
  end

  def update_user
    current_user = User.find(params[:id])
    payload = JSON.parse(request.body.read)
    Validation.update_user_validate(payload)
    update_detail = custom_compact(payload)
    begin
      current_user.update!(update_detail)

      render json: current_user.as_json(except: [:password_digest, :created_at, :sub]), status: :ok
    rescue => exception
      render json: exception, status: :bad_request
    end
  end

  def show
    user = User.find_by(:id => params[:id])
    if user.present?
      render json: { data: user }, status: :ok
    else
      render json: { message: "User with Id: " + params[:id] + " is not found" }, status: :not_found
    end
  end

  private

  def custom_compact(payload)
    payload.reject { |key, value| value.empty? || key=="password"}
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :user_type)
  end
end
