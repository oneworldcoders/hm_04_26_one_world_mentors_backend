class AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  def create
    user = User.authenticate(login_params[:email], login_params[:password])
    if user
      token = JsonWebToken.encode({ "email" => user.email, "id" => user.id ,"firstname":user.first_name,"lastname":user.last_name, "user_type":user.user_type})
      render json: { "email": user.email, "token": token }, :status => :ok
    else
      render json: { error: "Invalid email or password", status: 403 }, :status => :forbidden
    end
  end

  def is_admin?
    current_user.role.label == "admin"
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
