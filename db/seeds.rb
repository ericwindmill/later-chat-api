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


#create users
guest = User.new({username: 'guest', password: 'password'})

50.times do
  user = User.new
  user.username = Faker::Internet.user_name
  user.password = 'password'
  user.save
end

users = User.all

#create follows

users.each do |user|
  30.times do
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

locations = ["Dolores Park", "Cafe", "Golden Gate Park", "McDonalds", "Ferry Building"]

users.each do |user|
  50.times do
    post = Post.new
    post.author_id = user.id
    post.body = Faker::Hipster.sentence
    post.location = locations.sample
    post.image_url = Faker::LoremPixel.image
    post.public = Faker::Boolean.boolean

    post.save

    #if post is not public AND randomly, make notes to users followers

    unless post.public && Faker::Boolean.boolean
      recipients = []
      rand(user.followers.length).times do
        recipients.push(user.followers.sample.id)
      end
      recipients.each do |recipient|
        note = Note.new
        note.post_id = post.id
        note.recipient_id = recipient
        note.save
      end
    end
  end
end
