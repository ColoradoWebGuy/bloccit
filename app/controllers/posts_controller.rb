class PostsController < ApplicationController
  def index
    @posts = Post.all

    #overwrite the title of every fifth instance of Post with the text "CENSORED".
    @posts.each { |x|
      x.title = "CENSORED" if x.id % 5 == 0
    }
  end

  def show
  end

  def new
  end

  def edit
  end
end
