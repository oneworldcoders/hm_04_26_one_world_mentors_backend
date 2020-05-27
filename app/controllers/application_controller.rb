class ApplicationController < ActionController::API
  before_action :authenticate_request, except: [:auth]
  rescue_from ActiveModel::UnknownAttributeError, with: :render_bad_request
  attr_reader :current_user

  def authenticate_request
    @current_user ||= Authorization.authorize(request.headers)
    render json: { error: "Missing token or Not Authorized" }, status: 401 unless @current_user
  end

  def render_bad_request(exception)
    render json: exception, status: :bad_request
  end
end
