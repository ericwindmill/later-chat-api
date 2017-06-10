@locations.each do |location|
  json.set! location do
    json.array! (@posts.select {|post| post.location == location}) do |post|
      json.extract! post, :id, :body, :image_url, :public
      json.author do
        json.extract! post.author, :id, :username
      end
      if post.notes
        json.read_status post.notes.find_by(recipient_id: @user.id).read_status
        json.note_id post.notes.find_by(recipient_id: @user.id).id
      end
    end
  end
end
