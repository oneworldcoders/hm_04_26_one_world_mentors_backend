class ApplicationController < ActionController::API
  rescue_from ValidationError, with: :render_validatoin_error
  before_action :authenticate_request, except: [:auth]
  attr_reader :current_user

  def render_validatoin_error(exception)
    if exception.message.present?
    render json: { "errors": exception.message }, status: 400
    end
  end

  def authenticate_request
    @current_user ||= Authorization.authorize(request.headers)
    render json: { error: "Missing token or Not Authorized" }, status: 401 unless @current_user
  end
  
end
