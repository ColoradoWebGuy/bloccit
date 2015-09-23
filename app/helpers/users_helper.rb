module UsersHelper

  def user_has_posts?
      true unless @user.posts.count == 0
  end

  def user_has_comments?
    true unless @user.comments.count == 0
  end

  def user_has_favorites?
    true unless @user.favorites.count == 0
  end
end
