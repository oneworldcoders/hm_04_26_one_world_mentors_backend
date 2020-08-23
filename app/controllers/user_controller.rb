class UserController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :signup]

  def index
    render json: { message: "Welcome to One world Mentors" }, status: 200
  end

  def signup
    @new_user = User.new(user_params)

    if @new_user.valid?
      @new_user.save

      render json: @new_user.as_json(except: [:password]), status: 201
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
    upload_image = Cloudinary::Uploader.upload(params["image_url"], :width => 300, :height => 300, :crop => "scale")
    user = { image_url: upload_image["url"] }
    current_user.update!(user)
    render json: { url: upload_image["url"] }, status: :ok
  end

  def create_admin
    if @current_user["user_type"] != "admin"
      return render json: { message: "Permission Denied " }, status: :unauthorized
    end
    @new_user = User.new(user_params)
    @new_user.user_type = "admin"
    if @new_user.valid?
      @new_user.save

      render json: @new_user.as_json(except: [:password]), status: 201
    end
  end

  def update_user_role
    if @current_user["user_type"] != "admin"
      return render json: { message: "Permission Denied " }, status: :unauthorized
    end
    user = User.find_by(:id => params[:id])
    if user.present?
      new_role = { :user_type => params[:user_type] }
      user.update(new_role)
      render json: { message: "User role updated succesfully", user: user }, status: 200
    else
      render json: { message: "User does not exist" }, status: 404
    end
  end

  def rate_mentor
    new_rate = Rating.new(rate_params)
    if new_rate.valid?
      new_rate.save

      ratings = Rating.where(mentor_id: new_rate.mentor_id, course_id: new_rate.course_id)

      total_rate = ratings.sum { |a| a.mark }

      average_rate = total_rate / ratings.length

      mentor_course = MentorCourse.where(mentor_id: new_rate.mentor_id, course_id: new_rate.course_id)
      new_average_rate = { :average_rate => average_rate }
      mentor_course.update(new_average_rate)

      render json: { data: new_rate }, status: 201
    else
      render json: new_rate.errors.details, status: 500
    end
  end

  private

  def custom_compact(payload)
    payload.reject { |_, value| value.empty? }
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :user_type)
  end

  def rate_params
    params.permit(:mark, :mentee_id, :course_id, :mentor_id)
  end

  def encrypt_password(password)
    encrypted_password = BCrypt::Password.create(password)
    @new_user.password = encrypted_password
  end
end
