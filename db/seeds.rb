# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


User.destroy_all
Post.destroy_all
Note.destroy_all
Follow.destroy_all

# Coit Tower, 37.802374,-122.4080011
# Trick Dog, 37.7592213,-122.4133992
# Ferry Building Marketplace, 37.795274,-122.3956043
# Golden Gate Bridge, 37.8199286,-122.4804384
# Sutro Baths, 37.7804369,-122.5158768
# Alcatraz Island, 37.8269775,-122.4251388
# Mission Dolores Park, 37.7596168,-122.4290871

#create users
guest = User.new({username: 'guest', password: 'password'})

10.times do
  user = User.new
  user.username = Faker::Internet.user_name
  user.password = 'password'
  user.save
end

users = User.all

#create follows

users.each do |user|
  10.times do
    leader = users.sample
    while leader.id == user.id
      leader = users.sample
    end

    f = Follow.new
    f.follower_id = user.id
    f.leader_id = leader.id

    f.save
  end
end

#create posts

# Coit Tower, 37.802374,-122.4080011
# Trick Dog, 37.7592213,-122.4133992
# Ferry Building Marketplace, 37.795274,-122.3956043
# Golden Gate Bridge, 37.8199286,-122.4804384
# Sutro Baths, 37.7804369,-122.5158768
# Alcatraz Island, 37.8269775,-122.4251388
# Mission Dolores Park, 37.7596168,-122.4290871

locations = [
  "Mission Dolores Park", "Coit Tower", "Trick Dog", "Alcatraz Island",
  "Ferry Building Marketplace", "Golden Gate Bridge", "Sutro Baths"
]

users.each do |user|
  15.times do
    post = Post.new
    post.author_id = user.id
    post.body = ""
    ((rand*3)+1).round.times do
      post.body += "#{Faker::ChuckNorris.fact} "
    end
    post.location = locations.sample
    post.image_url = 'https://loremflickr.com/640/480/dog'
    post.public = Faker::Boolean.boolean

    post.save
  end
end


Post.all.each do |post|
  unless post.public && Faker::Boolean.boolean
    recipients = []
    rand(post.author.followers.length).times do
      recipients.push(post.author.followers.sample.id)
    end
    recipients.uniq.each do |recipient|
      note = Note.new
      note.post_id = post.id
      note.recipient_id = recipient
      note.save
    end
  end
end
