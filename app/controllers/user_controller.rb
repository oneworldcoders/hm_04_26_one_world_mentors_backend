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
    update_detail = custom_compact(payload)
    current_user.update!(update_detail)
    render json: current_user, status: :ok
  end

  def show
    user = User.find_by(:id => params[:id])
    if user.present?
      render json: { data: user }, status: :ok
    else
      render json: { message: "User with Id: " + params[:id] + " is not found" }, status: :not_found
    end
  end

  def update_profile_image
    current_user = User.find_by(:id => params[:id])
    upload_image = Cloudinary::Uploader.upload(params["image_url"], :width=>300, :height=>300, :crop=>"scale")
    user = { image_url: upload_image["url"] }
    current_user.update!(user)
    render json: { url: upload_image["url"] }, status: :ok
  end

  private

  def custom_compact(payload)
    payload.reject { |_, value| value.empty? }
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :user_type)
  end

  def encrypt_password(password)
    encrypted_password = BCrypt::Password.create(password)
    @new_user.password = encrypted_password
  end

end
