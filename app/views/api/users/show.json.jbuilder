json.extract! @user, :id, :username, :auth_token

json.followers do
  @user.followers.each do |follower|
    json.set! follower.id do
      json.extract! follower, :id, :username
    end
  end
end

json.leaders do
  @user.leaders.each do |leader|
    json.set! leader.id do
      json.extract! leader, :id, :username
    end
  end
end
