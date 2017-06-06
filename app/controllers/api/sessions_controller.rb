class Api::SessionsController < ApplicationController

  # def create
  #   @user = User.find_by_credentials(
  #   params[:user][:username],
  #   params[:user][:password]
  #   )

  #   if @user
  #     login(@user)
  #     render "api/users/show"
  #   else
  #     render(
  #     json: ["Invalid username/password combination"],
  #     status: 401
  #     )
  #   end
  # end

  # def destroy
  #   @user = current_user
  #   if @user
  #     logout
  #     render "api/users/show"
  #   else
  #     render(
  #     json: ["Nobody signed in"],
  #     status: 404
  #     )
  #   end
  # end

  ### TOKEN AUTH TESTS

  skip_before_action :require_login!, only: [:create]

  #create a new session if the user is found by email, but only if the user passes
  # I changed whatever devise method he was using to find_by(email: email). I don't know if that's right.
  def create
    @resource = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @resource
      auth_token = @resource.generate_auth_token
      render :session
      # render json: { auth_token: auth_token, username: @resource.username }
      # render json: { auth_token: auth_token }
    else
      return invalid_login_attempt
    end

    # resource = User.find_by(email: email)

    ## I added my own valid password method because the guide uses Devise. Does this seem right?
    # if resource.valid_password?(params[:username][:password])
    # else
    #   invalid_login_attempt
    # end

    # def valid_password?(password) {
    #   return false unless (resource.password === password)
    # }

  end

  # on log out, grab the current user and remove the auth token
  def destroy
    resource = current_user
    resource.invalidate_auth_token
    head :ok
  end


  # helper method to render invalid credentials error
  def invalid_login_attempt
    render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
  end


end
