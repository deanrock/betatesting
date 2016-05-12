class Api::V1::BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :destroy_session
  before_action :authenticate_user!, :except => [:upload]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  protected

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found!
    return api_error(status: 404, errors: 'Not found')
  end

  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render json: { error: 'Bad credentials' }, status: 401
  end

  def authenticate_api!
    if not ActiveSupport::SecurityUtils.secure_compare(ENV['api_token'], params[:token])
      unauthenticated!
    end
  end
end