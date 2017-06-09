class ApplicationController < ActionController::Base
  #commented for testing api
  #protect_from_forgery with: :exception

  ### TOKEN BASED AUTH
  #before_action :require_login!
  helper_method :person_signed_in?, :current_user

  #present is a built in method that checks if an object is nil
  def user_signed_in?
    current_user.present?
  end

  ## this essentially replaces our logged_in? method.
  def require_login!
    return true if authenticate_token
    render json: { errors: [ { detail: "Access denied" } ] }, status: 401
  end

  #find the current user by searching via the auth token
  def current_user
    @_current_user ||= authenticate_token
  end

  private
  # authenticate the user via the token that the user passes from their async storage
    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end
end
