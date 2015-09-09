class PostsController < ApplicationController
  def index
    @posts = Post.censored
  end

  def show
  end

  def new
  end

  def edit
  end
end
