json.extract! @post, :id, :body, :location, :image_url, :public
json.author do
  json.extract! @post.author, :id, :username
end
json.read_status do
  json.extract! @post.notes.find_by(recipient_id: @user.id).read_status
end