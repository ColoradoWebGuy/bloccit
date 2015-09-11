class SponsoredPostsController < ApplicationController
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @topic = Topic.find(params[:topic_id])

    @sponsored_post.topic = @topic

    # If save is a success, Redirecting to @sponsored_post will direct the user to the
    #  sponsored post show view.
    if @sponsored_post.save
      flash[:notice] = "Sponsor Post was saved."
      redirect_to [@topic, @sponsored_post]
    else
      flash[:error] = "There was an error saving the sponsor post. Please try again."
      render :new
    end
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]

    if @sponsored_post.save
      flash[:notice] = "Sponsor Post was updated"
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash[:error] = "There was an error saving the sponsor post. Please try again."
      render :edit
    end
  end

end
