class Api::FollowsController < ApplicationController

  def create
    @follow = Follow.new(follow_params)
    if @follow.save
      # returns the id of the leader to be added to the current
      # user's leaders array
      render json: @follow.leader_id
    else
      render json: @follow.errors.full_messages, status: 422
    end
  end

  def destroy
    @follow = Follow.find_by(follow_params)
    @follow.destroy
    # returns the id of the leader to be removed from the current
    # user's leaders array
    render json: @follow.leader_id
  end

  def follow_params
    params.require(:follow).permit(:leader_id, :follower_id)
  end

end
