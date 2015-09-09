class Post < ActiveRecord::Base
  has_many :comments

  #overwrite the title of every fifth instance of Post with the text "CENSORED".
  def self.censored
    all.each { |post|
      post.title = "CENSORED" if post.id % 5 == 0
    }
  end

end
