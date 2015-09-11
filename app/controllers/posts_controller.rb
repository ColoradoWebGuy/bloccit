class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end


  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  # create is a POST action
  def create
    # Call Post.new to create a new instance of Post
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])

    @post.topic = @topic

    # If save is a success, Redirecting to @post will direct the user to the
    #  posts show view.
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    # grabs the id from the view, & then grabs the data from Post.find()
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was updated"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
     @post = Post.find(params[:id])

     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to @post.topic
     else
       flash[:error] = "There was an error deleting the post."
       render :show
     end
  end

end #end of PostsController
