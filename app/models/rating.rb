class Rating < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true

  enum severity: [ :PG, :PG13, :R ]

  def self.update_rating(rating_string)
     unless rating_string.nil? || rating_string.empty?
         rating_desired = rating_string.to_sym
         Rating.find_or_create_by(severity: rating_desired)
     end
  end
  
end
