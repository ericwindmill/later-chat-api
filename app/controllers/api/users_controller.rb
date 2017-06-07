class Api::UsersController < ApplicationController

  def index
    @users = User.limit(10).where(["lower(username) LIKE ?", "%#{params[:searchStr].downcase}%"])
    render :index
  end

	def create
		@user = User.new(user_params)

		if @user.save
      @user.generate_auth_token
			render :show
		else
			render json: @user.errors.full_messages, status: 422
		end

	end

	private

	def user_params
		params.require(:user).permit(:username, :password)
	end


end
