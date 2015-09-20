class Rating < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true
  
  enum severity: [ :PG, :PG13, :R ]

  has_many :topics, through: :rateable, source: :rateable, source_type: :Topic
  has_many :posts, through: :rateable, source: :rateable, source_type: :Post

  def self.update_rating(rating_string)
     unless rating_string.nil? || rating_string.empty?
         rating_desired = rating_string.strip.upcase
         new_rating = Rating.find_or_create_by(severity: rating_desired)
     end
     new_rating
   end
end
