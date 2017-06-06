json.extract! @resource, :id, :username, :auth_token

json.followers do
  @resource.followers.each do |follower|
    json.set! follower.id do
      json.extract! follower, :id, :username
    end
  end
end

json.leaders do
  @resource.leaders.each do |leader|
    json.set! leader.id do
      json.extract! leader, :id, :username
    end
  end
end
