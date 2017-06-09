class Api::SessionsController < ApplicationController
  skip_before_action :require_login!, only: [:create, :verify_access_token], raise: false

  #create a new session if the user is found by email, but only if the user passes
  def create
    @resource = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @resource
      auth_token = @resource.generate_auth_token
      render :session
    else
      return invalid_login_attempt
    end
  end

  # on log out, grab the current user and remove the auth token
  def destroy
    resource = current_user
    resource.invalidate_auth_token
    head :ok
  end

  def show
    @user = User.find_by_auth_token(params[:auth_token])
    if @user
      render :show
    else
      render text: "User not found"
    end
  end

  # helper method to render invalid credentials error
  def invalid_login_attempt
    render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
  end

  def verify_access_token
    user = User.find_by(auth_token: params[:session][:access_token])
    if user
      render text: "verified", status: 200
    else
      render text: "Token failed verification", status: 422
    end
  end


end
