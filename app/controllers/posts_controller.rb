class PostsController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]

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
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

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
    @post.assign_attributes(post_params)

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

  # Any method defined below private, will be private.
  private

   def post_params
     params.require(:post).permit(:title, :body)
   end

   def authorize_user
     post = Post.find(params[:id])
     unless current_user == post.user || current_user.admin? || (current_user.moderator? && params[:action] != "destroy")
       flash[:error] = "You must be an admin to do that."
       redirect_to [post.topic, post]
     end
   end
end #end of PostsController
