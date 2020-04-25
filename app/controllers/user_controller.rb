class UserController < ApplicationController
  def index
    render json: {message: 'Welcome to One world Mentor'}, status: 200
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

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :user_type)
  end
end
