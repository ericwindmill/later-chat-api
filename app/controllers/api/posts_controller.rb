class Api::PostsController < ApplicationController

  def index
    #to pass params in a 'GET' request, must pass it in the query string
    #ex. .../api/posts?type=post&locations[]=Dolores%20Park&locations[]=Cafe
    @locations = params[:locations]
    if params[:type] == 'post'
      @posts = Post.includes(:author).limit(50).where("public = true AND location IN (?)", @locations)

    #for time being and testing purposes, this current controller doesn't have access to 'current_user.id'
    #so, to receive the notes for a user, send it in the query string like so: /api/posts?type=note&recipient_id=4&locations[]=Dolores%20Park
  elsif params[:type] == 'note'
      # Finding notes for currentUser by the notes recipients ID using through association. (And based on location)
      @user = User.find(params[:recipient_id])
      @posts = @user.notes.includes(:author).where("location IN (?)", @locations)
      render 'api/notes/index'
    end
  end

  def create
    #Note is a joins table so we always need a post.
    @post = Post.new(post_params)
    if @post.save
      if params[:post][:recipients]
        params[:post][:recipients].each do |recipient|
          Note.create(post_id: @post.id, recipient_id: recipient.to_i)
        end
      end
      render 'api/posts/show'
    else
      render json: @post.errors.full_messages, status: 422
    end

  end

  def update
    @note = Note.find(params[:note_id])
    if @note
      @note.update(read_status: true)
      render 'api/notes/show'
    else
      render json: @note.errors.full_messages, status: 405
    end
  end

  def post_params
    params.require(:post).permit(:body, :location, :image_url, :author_id, :public)
  end

end



User.joins('INNER JOIN notes ON users.id = notes.recipient_id INNER JOIN posts ON notes.post_id = posts.id').where(id: 112)
