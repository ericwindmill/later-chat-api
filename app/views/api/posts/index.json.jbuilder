@locations.each do |location|
  json.set! location do
    json.array! (@posts.select {|post| post.location == location}) do |post|
      json.extract! post, :id, :body, :image_url, :public
      json.author do
        json.extract! post.author, :id, :username
      end
    end
  end
end
